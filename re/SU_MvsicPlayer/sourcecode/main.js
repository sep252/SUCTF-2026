const { app, BrowserWindow, dialog, ipcMain } = require("electron");
const fs = require("fs");
const path = require("path");

const { createVmEncryptorBridge } = require("./src/main/native-bridge");

const vmEncryptorBridge = createVmEncryptorBridge(__dirname);

const sessionState = {
  secureEnabled: false,
  currentSuMvPath: "",
  currentPayload: null,
  archivedPaths: new Set()
};

let mainWindow = null;
let forceClosing = false;
let archiveInFlight = false;

function toBufferOrNull(payload) {
  if (!payload) return null;
  if (Buffer.isBuffer(payload)) return payload;
  if (payload instanceof Uint8Array) return Buffer.from(payload);
  if (payload instanceof ArrayBuffer) return Buffer.from(new Uint8Array(payload));
  if (ArrayBuffer.isView(payload)) {
    return Buffer.from(payload.buffer, payload.byteOffset, payload.byteLength);
  }
  if (payload && Array.isArray(payload.data)) return Buffer.from(payload.data);
  return null;
}

async function secureArchive(sourcePath, payloadBytes) {
  if (!sourcePath || !Buffer.isBuffer(payloadBytes) || payloadBytes.length === 0) {
    return { ok: false };
  }

  if (sessionState.archivedPaths.has(sourcePath)) {
    return { ok: true, skipped: true };
  }

  if (!fs.existsSync(sourcePath)) {
    return { ok: false };
  }

  const encryptedBytes = vmEncryptorBridge.vmEncrypt(payloadBytes);
  const outputPath = `${sourcePath}_enc`;

  await fs.promises.writeFile(outputPath, encryptedBytes);
  await fs.promises.unlink(sourcePath);

  sessionState.archivedPaths.add(sourcePath);
  return { ok: true, outputPath };
}

async function archiveIfNeeded() {
  if (
    !sessionState.secureEnabled ||
    !sessionState.currentSuMvPath ||
    sessionState.archivedPaths.has(sessionState.currentSuMvPath)
  ) {
    return { ok: true, skipped: true };
  }

  if (archiveInFlight) {
    return { ok: true, skipped: true };
  }

  archiveInFlight = true;
  try {
    return await secureArchive(sessionState.currentSuMvPath, sessionState.currentPayload);
  } finally {
    archiveInFlight = false;
  }
}

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 620,
    height: 500,
    minWidth: 460,
    minHeight: 380,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
      nodeIntegration: false,
      contextIsolation: true,
      sandbox: false
    }
  });

  mainWindow.loadFile(path.join(__dirname, "src/renderer/index.html"));

  mainWindow.on("close", (event) => {
    if (forceClosing) {
      return;
    }

    if (!sessionState.secureEnabled || !sessionState.currentSuMvPath) {
      return;
    }

    event.preventDefault();
    archiveIfNeeded()
      .catch(() => {})
      .finally(() => {
        forceClosing = true;
        mainWindow.close();
      });
  });
}

function registerIpcHandlers() {
  ipcMain.handle("dialog:open-su-mv", async () => {
    const result = await dialog.showOpenDialog({
      title: "Open .su_mv File",
      properties: ["openFile"],
      filters: [{ name: "SU_MV", extensions: ["su_mv"] }]
    });

    if (result.canceled || result.filePaths.length === 0) {
      return "";
    }
    return result.filePaths[0];
  });

  ipcMain.handle("file:read-binary", async (_event, filePath) => {
    const fileBytes = await fs.promises.readFile(filePath);
    return new Uint8Array(fileBytes);
  });

  ipcMain.handle(
    "session:update",
    async (_event, { secureEnabled, currentSuMvPath, currentPayload }) => {
      sessionState.secureEnabled = Boolean(secureEnabled);
      sessionState.currentSuMvPath = currentSuMvPath || "";
      sessionState.currentPayload = toBufferOrNull(currentPayload);
      return { ok: true };
    }
  );

  ipcMain.handle("playback:ended", async () => {
    return archiveIfNeeded();
  });

  ipcMain.handle("secure:archive-now", async (_event, sourcePath) => {
    return secureArchive(sourcePath, sessionState.currentPayload);
  });
}

app.whenReady().then(() => {
  registerIpcHandlers();
  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      forceClosing = false;
      createWindow();
    }
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});
