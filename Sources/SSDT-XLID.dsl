/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLIZtfno.aml, Sat Dec 30 19:46:16 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000B3 (179)
 *     Revision         0x02
 *     Checksum         0xFE
 *     OEM ID           "OCLT"
 *     OEM Table ID     "LIDpatch"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "OCLT", "LIDpatch", 0x00000000)
{
    External (_SB_.LID0, DeviceObj)
    External (_SB_.LID0.XLID, MethodObj)    // 0 Arguments
    External (_SB_.PCI9.FNOK, IntObj)

    Scope (_SB.LID0)
    {
        Method (_LID, 0, NotSerialized)  // _LID: Lid Status
        {
            If (_OSI ("Darwin"))
            {
                If ((\_SB.PCI9.FNOK == One))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (\_SB.LID0.XLID ())
                }
            }
            Else
            {
                Return (\_SB.LID0.XLID ())
            }
        }
    }
}

