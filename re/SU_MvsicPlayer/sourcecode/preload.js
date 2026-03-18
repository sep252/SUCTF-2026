const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("suPlayerApi", {
  openSuMvDialog: () => ipcRenderer.invoke("dialog:open-su-mv"),
  readBinaryFile: (filePath) => ipcRenderer.invoke("file:read-binary", filePath),
  updateSession: ({ secureEnabled, currentSuMvPath, currentPayload }) =>
    ipcRenderer.invoke("session:update", { secureEnabled, currentSuMvPath, currentPayload }),
  notifyPlaybackEnded: () => ipcRenderer.invoke("playback:ended"),
  archiveNow: (sourcePath) => ipcRenderer.invoke("secure:archive-now", sourcePath)
});
