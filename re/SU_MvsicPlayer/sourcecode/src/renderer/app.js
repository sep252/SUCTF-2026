const audioElement = document.getElementById("audioElement");
const openBtn = document.getElementById("openBtn");
const seekBackBtn = document.getElementById("seekBackBtn");
const playPauseBtn = document.getElementById("playPauseBtn");
const playPauseIcon = document.getElementById("playPauseIcon");
const seekForwardBtn = document.getElementById("seekForwardBtn");
const secureToggle = document.getElementById("secureToggle");
const seekBar = document.getElementById("seekBar");
const currentTimeText = document.getElementById("currentTime");
const totalTimeText = document.getElementById("totalTime");
const fileHint = document.getElementById("fileHint");

const state = {
  currentSuMvPath: "",
  currentObjectUrl: "",
  currentPayload: null
};

function setStatus(_message, _isError = false) {
  // Status text output removed by UI requirement.
}

function basename(filePath) {
  if (!filePath) {
    return "";
  }
  const normalized = filePath.replaceAll("\\", "/");
  return normalized.slice(normalized.lastIndexOf("/") + 1);
}

function formatTime(seconds) {
  if (!Number.isFinite(seconds)) {
    return "00:00";
  }
  const clamped = Math.max(0, Math.floor(seconds));
  const mm = String(Math.floor(clamped / 60)).padStart(2, "0");
  const ss = String(clamped % 60).padStart(2, "0");
  return `${mm}:${ss}`;
}

function updateTimeline() {
  const current = Number.isFinite(audioElement.currentTime) ? audioElement.currentTime : 0;
  const duration = Number.isFinite(audioElement.duration) ? audioElement.duration : 0;
  seekBar.max = Math.max(1, Math.floor(duration));
  seekBar.value = Math.floor(current);
  currentTimeText.textContent = formatTime(current);
  totalTimeText.textContent = formatTime(duration);
}

function updatePlayPauseIcon() {
  const isPlaying = !audioElement.paused && !audioElement.ended;
  playPauseIcon.src = isPlaying ? "./icons/pause.png" : "./icons/play.png";
  playPauseBtn.title = isPlaying ? "Pause" : "Play";
}

function updateSession() {
  return window.suPlayerApi.updateSession({
    secureEnabled: secureToggle.checked,
    currentSuMvPath: state.currentSuMvPath,
    currentPayload: state.currentPayload
  });
}

function hasLoadedAudio() {
  return Boolean(state.currentObjectUrl) || Boolean(audioElement.currentSrc || audioElement.src);
}

function revokeCurrentObjectUrl() {
  if (state.currentObjectUrl) {
    URL.revokeObjectURL(state.currentObjectUrl);
    state.currentObjectUrl = "";
  }
}

function toArrayBuffer(bytes) {
  return bytes.buffer.slice(bytes.byteOffset, bytes.byteOffset + bytes.byteLength);
}

async function probeAudioPlayable(mediaUrl, timeoutMs = 5000) {
  return new Promise((resolve) => {
    const probe = new Audio();
    let settled = false;

    const finish = (result) => {
      if (settled) {
        return;
      }
      settled = true;
      clearTimeout(timer);
      probe.removeAttribute("src");
      probe.load();
      resolve(result);
    };

    const onPlayable = () => finish(true);
    const onError = () => finish(false);

    probe.addEventListener("loadedmetadata", onPlayable, { once: true });
    probe.addEventListener("canplay", onPlayable, { once: true });
    probe.addEventListener("error", onError, { once: true });

    const timer = setTimeout(() => finish(false), timeoutMs);
    probe.src = mediaUrl;
    probe.load();
  });
}

async function loadPayloadToAudio(payload) {
  const blob = new Blob([toArrayBuffer(payload)], {
    type: "application/octet-stream"
  });
  const objectUrl = URL.createObjectURL(blob);
  const playable = await probeAudioPlayable(objectUrl);

  if (!playable) {
    URL.revokeObjectURL(objectUrl);
    throw new Error("Not playable!");
  }

  revokeCurrentObjectUrl();
  state.currentObjectUrl = objectUrl;
  audioElement.src = objectUrl;
  audioElement.load();
}

async function openSuMvFile() {
  const filePath = await window.suPlayerApi.openSuMvDialog();
  if (!filePath) {
    return;
  }

  const fileBytes = await window.suPlayerApi.readBinaryFile(filePath);
  const parsed = await window.SUMV.parseSuMv(new Uint8Array(fileBytes));

  await loadPayloadToAudio(parsed.payload);

  state.currentSuMvPath = filePath;
  state.currentPayload = parsed.payload;
  await updateSession();
  fileHint.textContent = basename(filePath);
  updatePlayPauseIcon();
}

async function onPlaybackEnded() {
  if (!secureToggle.checked) {
    return;
  }

  const archiveResult = await window.suPlayerApi.notifyPlaybackEnded();
  if (!archiveResult.ok) {
    throw new Error("Secure storage failed!");
  }
}

async function init() {
  await updateSession();

  openBtn.addEventListener("click", async () => {
    try {
      await openSuMvFile();
    } catch (_error) {
      window.alert("Decode su_mv failed!");
      setStatus("E", true);
    }
  });

  playPauseBtn.addEventListener("click", async () => {
    if (!hasLoadedAudio()) {
      window.alert("No file loaded!");
      return;
    }

    if (audioElement.paused || audioElement.ended) {
      try {
        await audioElement.play();
      } catch (_error) {
        setStatus("E", true);
      }
      updatePlayPauseIcon();
      return;
    }
    audioElement.pause();
    updatePlayPauseIcon();
  });

  seekBackBtn.addEventListener("click", () => {
    audioElement.currentTime = Math.max(0, audioElement.currentTime - 10);
    updateTimeline();
  });

  seekForwardBtn.addEventListener("click", () => {
    const duration = Number.isFinite(audioElement.duration) ? audioElement.duration : 0;
    audioElement.currentTime = Math.min(duration || 0, audioElement.currentTime + 10);
    updateTimeline();
  });

  seekBar.addEventListener("input", () => {
    audioElement.currentTime = Number(seekBar.value);
  });

  secureToggle.addEventListener("change", async () => {
    try {
      await updateSession();
    } catch (_error) {
      setStatus("E", true);
    }
  });

  audioElement.addEventListener("timeupdate", updateTimeline);
  audioElement.addEventListener("loadedmetadata", updateTimeline);
  audioElement.addEventListener("play", updatePlayPauseIcon);
  audioElement.addEventListener("pause", updatePlayPauseIcon);
  audioElement.addEventListener("ended", updatePlayPauseIcon);
  audioElement.addEventListener("ended", () => {
    onPlaybackEnded().catch(() => {
      setStatus("E", true);
    });
  });

  window.addEventListener("beforeunload", () => {
    revokeCurrentObjectUrl();
  });

  updateTimeline();
  updatePlayPauseIcon();
}

init().catch(() => {
  setStatus("E", true);
});
