# Ntrip

Simple NTRIP caster/client/server example programs, support the NTRIP 1.0/2.0 protocol;



## Quick Start

This assumes you are running Ubuntu 16.04

Clone and run the build:

```bash
$ make config
$ make build
```

First step, run the `ntrip_caster_exam`:
```bash
$ ./build/examples/ntrip_caster_exam
```

Second step, run the `ntrip_server_exam`:
```bash
$ ./build/examples/ntrip_server_exam
```

Third step， run the `ntrip_client_exam`:
```bash
$ ./build/examples/ntrip_client_exam
```

After the above steps are completed, you can see that the example data sent by **NtripServer** flows to **NtripClient** through **NtripCaster**.



## CMake

### Linux

Configure and compile:

```bash
$ cmake -S . -B build
$ cmake --build build
```

Output executable file:

```bash
build/examples/ntrip_caster_exam
build/examples/ntrip_client_exam
build/examples/ntrip_client_to_ntrip_server_exam
build/examples/ntrip_server_exam
```

### Windows

#### VS2019

Configure and compile:

```bash
$ cmake -S . -B build -G "Visual Studio 16"
$ cmake --build build --config Release
```

Or open `build/ntrip.sln` with **VS2019** after the configuration is complete.

Output executable file:

```bash
build/examples/Release/ntrip_caster_exam.exe
build/examples/Release/ntrip_client_exam.exe
build/examples/Release/ntrip_client_to_ntrip_server_exam.exe
build/examples/Release/ntrip_server_exam.exe
```

#### MinGW

Configure and compile:

```bash
$ cmake -S . -B build -G "Unix Makefiles"
$ cmake --build build
```

Output executable file:

```bash
build/examples/ntrip_caster_exam
build/examples/ntrip_client_exam
build/examples/ntrip_client_to_ntrip_server_exam
build/examples/ntrip_server_exam
```



All example targets are enabled by default. If needed, you can disable individual
components with `-DNTRIP_BUILD_CASTER=OFF`, `-DNTRIP_BUILD_CLIENT=OFF`, or
`-DNTRIP_BUILD_SERVER=OFF`.

