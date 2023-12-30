/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLIEDIKw.aml, Sat Dec 30 19:46:16 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000101 (257)
 *     Revision         0x02
 *     Checksum         0x68
 *     OEM ID           "OCLT"
 *     OEM Table ID     "FnInsert"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "OCLT", "FnInsert", 0x00000000)
{
    External (_SB_.PCI9.FNOK, IntObj)
    External (_SB_.PCI9.MODE, IntObj)
    External (_SB_.XTNV, MethodObj)    // 2 Arguments

    Scope (_SB)
    {
        Method (BTNV, 2, NotSerialized)
        {
            If ((_OSI ("Darwin") && (Arg0 == 0x02)))
            {
                If ((\_SB.PCI9.MODE == One))
                {
                    \_SB.PCI9.FNOK = One
                    \_SB.XTNV (Arg0, Arg1)
                }
                Else
                {
                    If ((\_SB.PCI9.FNOK != One))
                    {
                        \_SB.PCI9.FNOK = One
                    }
                    Else
                    {
                        \_SB.PCI9.FNOK = Zero
                    }

                    \_SB.XTNV (0x03, Arg1)
                }
            }
            Else
            {
                \_SB.XTNV (Arg0, Arg1)
            }
        }
    }
}

