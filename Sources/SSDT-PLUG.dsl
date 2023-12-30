/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLwlEmV2.aml, Sat Dec 30 19:13:04 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000A1 (161)
 *     Revision         0x02
 *     Checksum         0x92
 *     OEM ID           "ACDT"
 *     OEM Table ID     "CpuPlug"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180105 (538444037)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "CpuPlug", 0x00003000)
{
    External (_PR_.CPU0, ProcessorObj)

    Method (PMPM, 4, NotSerialized)
    {
        If ((Arg2 == Zero))
        {
            Return (Buffer (One)
            {
                 0x03                                             // .
            })
        }

        Return (Package (0x02)
        {
            "plugin-type", 
            One
        })
    }

    If (CondRefOf (\_PR.CPU0))
    {
        If ((ObjectType (\_PR.CPU0) == 0x0C))
        {
            Scope (\_PR.CPU0)
            {
                If (_OSI ("Darwin"))
                {
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Return (PMPM (Arg0, Arg1, Arg2, Arg3))
                    }
                }
            }
        }
    }
}

