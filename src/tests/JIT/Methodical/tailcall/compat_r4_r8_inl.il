// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Console
{
  .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A )
  .ver 4:0:0:0
}
.assembly extern mscorlib { }
.assembly compat_r4_r8_inl { }
.assembly extern xunit.core {}
.namespace JitTest
{
  .class private auto ansi beforefieldinit Test
         extends [mscorlib]System.Object
  {
    .method private hidebysig static 
            float32 Method1() il managed
    {
      .maxstack  8
      IL_0000:  ldc.r4     10.
      IL_0005:  ret
    } 

    .method private hidebysig static 
            float64 Method2() il managed
    {
      .maxstack  8
      IL_0000:  tail.
      IL_0002:  call       float32 JitTest.Test::Method1()
      IL_0007:  ret
    } 

    .method private hidebysig static 
            int32 Main() il managed
    {
      .custom instance void [xunit.core]Xunit.FactAttribute::.ctor() = (
          01 00 00 00
      )
      .entrypoint
      .maxstack  8
      .locals (int32 V_0)
      IL_0000:  call       float64 JitTest.Test::Method2()
      IL_0005:  dup
      IL_0006:  ldc.r8     10.
      IL_000f:  beq.s      IL_001a

      IL_0011:  call       void [System.Console]System.Console::WriteLine(float64)
      IL_0016:  ldc.i4.1
      IL_0017:  stloc.0
      IL_0018:  br.s       IL_002a

      IL_001a:  pop
      IL_001b:  ldstr      "passed"
      IL_0020:  call       void [System.Console]System.Console::WriteLine(class System.String)
      IL_0025:  ldc.i4.s   100
      IL_0027:  stloc.0
      IL_0028:  br.s       IL_002a

      IL_002a:  ldloc.0
      IL_002b:  ret
    } 

    .method public hidebysig specialname rtspecialname 
            instance void .ctor() il managed
    {
      .maxstack  8
      IL_0000:  ldarg.0
      IL_0001:  call       instance void [mscorlib]System.Object::.ctor()
      IL_0006:  ret
    } 

  } 

} 
