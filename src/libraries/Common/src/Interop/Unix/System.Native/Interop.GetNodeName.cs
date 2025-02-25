// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;

internal static partial class Interop
{
    internal static partial class Sys
    {
        [GeneratedDllImport(Libraries.SystemNative, EntryPoint = "SystemNative_GetNodeName", SetLastError = true)]
        private static unsafe partial int GetNodeName(byte* name, ref int len);

        internal static unsafe string GetNodeName()
        {
            // max value of _UTSNAME_LENGTH on known Unix platforms is 1024.
            const int _UTSNAME_LENGTH = 1024;
            int len = _UTSNAME_LENGTH;
            byte* name = stackalloc byte[_UTSNAME_LENGTH];
            int err = GetNodeName(name, ref len);
            if (err != 0)
            {
                // max domain name can be 255 chars.
                Debug.Fail($"{nameof(GetNodeName)} failed with error {err}");
                throw new InvalidOperationException($"{nameof(GetNodeName)}: {err}");
            }

            // Marshal.PtrToStringAnsi uses UTF8 on Unix.
            return Marshal.PtrToStringAnsi((IntPtr)name);
        }
    }
}
