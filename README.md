# 📺 CRT Arcade — Change Resolution

![AutoHotkey v2](https://img.shields.io/badge/AutoHotkey-v2.0-334455?logo=autohotkey&logoColor=white)
![Windows](https://img.shields.io/badge/platform-Windows-0078D6?logo=windows&logoColor=white)
![15 kHz](https://img.shields.io/badge/CRT-15%20kHz%20arcade-orange)

Tiny AutoHotkey v2 scripts that switch the Windows desktop resolution in one click — built for arcade cabinets and PCs driving a **15 kHz CRT**.

Double-click a script (or call it from your frontend / launch scripts) and the primary display jumps straight to that mode. No Control Panel, no menus, no fiddling with a dead-dark CRT trying to read tiny text.

---

## 📦 What's inside

| Script | Resolution | Typical use |
|---|---|---|
| `640x240.ahk` | 640 × 240 | Native 15 kHz progressive mode — most arcade games, emulators, frontends |
| `640x480.ahk` | 640 × 480 | Interlaced 480i mode — Windows desktop, menus, high-res games |

---

## ✅ Requirements

- **Windows**
- **[AutoHotkey v2.0](https://www.autohotkey.com/)** or later
- The target mode must **already exist** in your video driver. On a CRT setup that usually means a 15 kHz-capable driver with custom modelines, such as **CRT Emudriver** configured with **VMMaker**. If Windows doesn't know about 640×240, these scripts can't invent it.

---

## 🚀 Usage

**Manually:** double-click `640x240.ahk` or `640x480.ahk`.

**From a batch file or launcher:**

```bat
"C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" "C:\Arcade\tools\640x240.ahk"
start /wait "" "C:\Arcade\emulators\someemu\emu.exe" %1
"C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" "C:\Arcade\tools\640x480.ahk"
```

**As standalone executables:** compile them with Ahk2Exe (right-click → *Compile Script*) to get `640x240.exe` / `640x480.exe` that run on machines without AutoHotkey installed.

---

## ⚙️ How it works

Each script calls the Win32 display API directly:

1. `EnumDisplaySettingsA` reads the **current** mode of the primary display into a `DEVMODE` structure.
2. The width (`dmPelsWidth`) and height (`dmPelsHeight`) are overwritten with the new values.
3. `dmFields` is set to `0x5C0000` — width, height, bits-per-pixel and refresh rate — so **color depth and refresh rate are kept from the current mode**.
4. `ChangeDisplaySettingsA` applies it with flags `0`, which means the change is **dynamic**: it isn't written to the registry, so a reboot always brings you back to your saved default.

---

## ➕ Adding another resolution

Copy either script, rename it (e.g. `320x240.ahk`) and change the single call at the top:

```autohotkey
SetScreenResolution(320, 240)
```

Make sure that mode exists in your driver first.

---

## 🛠️ Troubleshooting

- **Nothing happens** → the requested mode isn't available for the current refresh rate / color depth. Check the modes your driver exposes (VMMaker modelines or Windows' *List All Modes*).
- **Wrong monitor changes** → the scripts always target the **primary** display. Set your CRT as the main display in Windows.
- **Script won't run** → make sure it's opening with AutoHotkey **v2**, not v1.

---

## 🔗 See also

- [model2-DS-launcher-esc-key](https://github.com/monster-javi/model2-DS-launcher-esc-key) — Sega Model 2 + DemulShooter launcher for Attract-Mode, from the same cabinet setup.

---

<p align="center">
  If this helped your cabinet and you'd like to support the project, buy me a coffee! ☕
  <br><br>
  <a href="https://ko-fi.com/R6R51FQ52H"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support me on Ko-fi" height="36"></a>
</p>
