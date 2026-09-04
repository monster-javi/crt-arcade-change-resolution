#Requires AutoHotkey v2.0

SetScreenResolution(640, 240)

SetScreenResolution(Width, Height) {
    DEVMODE := Buffer(156, 0)
    NumPut("UShort", 156, DEVMODE, 36)
    DllCall("EnumDisplaySettingsA", "Ptr", 0, "UInt", -1, "Ptr", DEVMODE)
    NumPut("UInt", 0x5c0000, DEVMODE, 40)
    NumPut("UInt", Width, DEVMODE, 108)
    NumPut("UInt", Height, DEVMODE, 112)
    Return DllCall("ChangeDisplaySettingsA", "Ptr", DEVMODE, "UInt", 0)
}