# Dell Latitude E5570 Hackintosh OpenCore

Install macOS Monterey on Dell Latitude E5570.

- [Overview](#overview)
- [Hardware specifications](#hardware-specifications)
- [Known issues](#known-issues)
- [How to install](#how-to-install)
- [Post install](#post-install)
- [BIOS Script](#bios-script)
- [Recommended apps for a better hackintosh experience](#recommended-apps-for-a-better-hackintosh-experience)
- [Credits/References](#creditsreferences)

## Overview

I've been daily driving this hackintosh for a while now, and it's stable enough for daily usage. However, some quirks and bugs do exist. Make sure you read through the guide to decide whether you wanna go with it.

**Disclamer**: I am not responsible for any damage you cause to your devices. Follow this guide at your own risks.

Before you start, make sure you have read [the bible](https://dortania.github.io/OpenCore-Install-Guide/) and got a fundamental understanding about the process. This guide will not be helpful if you do not know how to make a bootable installer for macOS.

## Hardware specifications

|          Component | Details                                    |
| -----------------: | :----------------------------------------- |
|              Model | Dell Latitude E5570                        |
|       BIOS Version | 1.34.3                                     |
|          Processor | Intel Core i7-6820HQ                       |
|             Memory | 2 x 8GB DDR4 2133MHz                       |
|          Hard Disk | LITEON CV5-8Q256 256GB                     |
|           Graphics | Intel HD Graphics 530 / AMD Radeon R7 M370 |
|            Display | 15.6" IPS FullHD Non-touch                 |
|              Audio | Realtek ALC293 (ALC3235)                   |
|           Ethernet | Intel I219-LM Gigabit Ethernet             |
| WiFi and Bluetooth | Intel Wireless-AC 8260 Dual Band           |
|           Touchpad | AlpsPS/2 ALPS DualPoint                    |
|     SD Card Reader | Realtek RTS525A                            |

[Dell Latitude E5570 Owner's Manual (PDF)](https://dl.dell.com/topicspdf/latitude-e5570-laptop_owners-manual_en-us.pdf)

## Known issues

- **AMD R7 M370** is not compatible with macOS, so it's disabled to save battery.
- **VGA Port** either works out-of-the-box or doesn't work at all. See [here](https://osxlatitude.com/forums/topic/18160-dell-latitude-e5570-how-to-get-vga-and-bluetooth-working-under-monterey/?do=findComment&comment=118362).
- **Combo jack's microphone** doesn't work (It seems possible to fix, but I'm not interested).
- **HDMI** might not work the first time you plug in. In that case, put the laptop to sleep, turn it back on, and re-plug in.
- **SD Card Reader** is ejected after wake up. See [here](https://github.com/0xFireWolf/RealtekCardReader/blob/main/Docs/KnownIssues.md#card-ejected-after-waked-up).
- Sometimes, the trackpad cursor arbitrarily jumps to a corner of the screen. This is a [driver issue](https://github.com/acidanthera/VoodooPS2), so I cannot do anything about it.
- For some Bluetooth devices, it might take a little longer to reconnect after sleep. Sometimes, Bluetooth devices will not reconnect until you unlock the lock screen.

Anything not listed here means they works normally.

## How to install

- Download the `EFI` folder
- [Generate your own SMBIOS](https://github.com/corpnewt/GenSMBIOS)
- Depends on whether you want to modify hidden settings in your BIOS, follow the corresponding guide:
  - [With modded BIOS](#with-modded-bios)
  - [Without modded BIOS](#without-modded-bios)
- [BIOS settings](#bios-settings)

**Note**:

This EFI is compatible with macOS Monterey. If you want to boot older versions, you need to change the following:

- Change `AirportItlwm` and `IntelBluetoothFirmware` to the version you want to boot
- `Security/SecureBootModel`: `j680`
  > Setting this value allows you to boot macOS 10.13.6 or newer. You can also set this to `Disabled`. In that case, you need to use `itlwm` and `HeliPort` instead of `AirportItlwm`.
- `APFS Versions`: See [here](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/skylake.html#apfs).
- For macOS 10.13.6, you also need to enable `NormalizeHeaders` under `ACPI/Quirks`, or you will get a [kernel panic](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/extended/kernel-issues.html#kernel-panic-appleacpiplatform-in-10-13).

### BIOS settings

See [here](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/skylake.html#intel-bios-settings).

### With modded BIOS

See [here](#bios-script).

### Without modded BIOS

In case you do not want to modify hidden settings in your BIOS, you do not need the `BIOS` folder.

You must, however, update the following values in the `config.plist` (use Ctrl+F to quickly find them):

- `DeviceProperties`: follow [this guide](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/skylake.html#deviceproperties)

Or copy the following into `Add/PciRoot(0x0)/Pci(0x2,0x0)` (using ProperTree):

```xml
    <key>framebuffer-patch-enable</key>
    <data>AQAAAA==</data>
    <key>framebuffer-stolenmem</key>
    <data>AAAwAQ==</data>
    <key>framebuffer-fbmem</key>
    <data>AACQAA==</data>
```

- `AppleXcpmCfgLock`: `True`
- `ReleaseUsbOwnership`: `True`

## Post-install

- [Boot without USB](https://dortania.github.io/OpenCore-Post-Install/universal/oc2hdd.html#grabbing-opencore-off-the-usb)
- Disable boot picker menu to boot straight into macOS: In `config.plist`, `Misc/Boot` -> `ShowPicker`: `False`
- If you encounter [sleep issues](https://dortania.github.io/OpenCore-Post-Install/universal/sleep.html#preparations), run the following in `Terminal`:

```bash
# From Dortania guide
sudo pmset autopoweroff 0
sudo pmset powernap 0
sudo pmset standby 0
sudo pmset proximitywake 0
sudo pmset tcpkeepalive 0

# Extra: Disable wake for network access
sudo pmset womp 0
```

- Enable TRIM support (optional): `sudo trimforce enable`

## BIOS script

Unlocking hidden settings in BIOS helps to improve the stability of our hack.

### Interpretation

A rough interpretation of each command is as follow:

- `setup_var.efi`: a tool for changing BIOS value, located in the same folder
- `0x109`: the variable offset (in this case, it corresponds to CFG-Lock)
- `0x0`: disabled
- `-n Setup`: the variable name (in this case, "Setup")

**Disclaimer**: The script is for reference purpose only. You should follow [this guide](https://github.com/dreamwhite/bios-extraction-guide/blob/master/Dell/README.md) to find your own value of each variable offset, as it might be different from my hardware or BIOS version.

### How to use

- Put the `BIOS folder` to the `EFI partition` of the same USB Drive you are using to boot macOS
- On startup, press `F12`. From boot menu, boot to your USB Drive
- Choose OpenShell in the Boot Picker menu (you might need to press `Space`)
- Press any key to prevent the autorun of default script
- Run `devtree -b` and look for the location of USB Drive
- Run `map -b -v` to see all devices in detail
- Find the USB Drive partition (FS0, for example)
- "cd" to the drive with `fs0:`
- "cd" into the BIOS folder
- Run `bios-config.nsh` and enjoy!

For a detailed guide, see [here](https://www.reddit.com/r/hackintosh/comments/sy2170/opencore_uefi_shell_for_hackintosh/).

## Recommended apps for a better hackintosh experience

- LinearMouse
- Rectangle
- AltTab
- TinkerTool

## Credits/References

- [OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/)
- [OC Little Translated](https://github.com/5T33Z0/OC-Little-Translated)
- [bios-extraction-guide](bios-extraction-guide)
- [dell-inspiron-5370-hackintosh](dell-inspiron-5370-hackintosh)
- [XiaoMi-Pro-Hackintosh](https://github.com/daliansky/XiaoMi-Pro-Hackintosh)
- [Power Management in detail: using pmset](https://eclecticlight.co/2017/01/20/power-management-in-detail-using-pmset/)
- and various sources on the Internet =))
