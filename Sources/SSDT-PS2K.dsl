/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLDOhYSU.aml, Sat Dec 30 19:45:11 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000C2 (194)
 *     Revision         0x02
 *     Checksum         0x31
 *     OEM ID           "ACDT"
 *     OEM Table ID     "Ps2"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "Ps2", 0x00000000)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Name (_SB.PCI0.LPCB.PS2K.RMCF, Package (0x02)
    {
        "Keyboard", 
        Package (0x04)
        {
            "Swap command and option", 
            ">y", 
            "Custom PS2 Map", 
            Package (0x06)
            {
                Package (0x00){}, 
                "46=0", 
                "e045=0", 
                "e037=64", 
                "e021=67", 
                "e065=68"
            }
        }
    })
}

