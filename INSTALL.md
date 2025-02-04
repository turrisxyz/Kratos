# Contents
* [Cloning Kratos](#cloning-kratos)
* [Kratos Dependencies](#kratos-dependencies)
  * [Kratos Core Dependencies](#kratos-core-dependencies)
    * [Linux Installation](#linux-installation)
    * [Windows Installation](#windows-installation)
  * [Specific Application Dependencies](#specific-application-dependencies)
* [Basic Configuration](#basic-configuration)
* [Examples](#configuration-scripts-examples)
  * [Linux](#linux)
  * [Windows](#windows)
  * [MacOS](#macos)
* [Adding Applications](#adding-applications)
* [Post Compilation](#post-compilation)
* [Advanced Configuration](#advanced-configuration)
  * [Building Environment](#building-environment)
  * [Common Flags](#common-flags)
  * [Unitary Builds](#unitary-builds)
  * [MPI-Parallelism](#parallelism)
  * [TPL Libraries](#tpl-libraries)

## Cloning Kratos

In order to obtain the source code of Kratos, you will need to clone the repository using git.

You can install git through the following command in Linux:
```Shell
sudo apt-get install git
```
In Windows, you can download it in:

* [Download Git](https://git-scm.com/downloads)



Once git is installed you can fetch the code by using this command in a terminal:

```Shell
git clone https://github.com/KratosMultiphysics/Kratos Kratos
```

## Kratos Dependencies

### Kratos Core Dependencies
  These are the basic dependecies needed to compile the Kratos Core and most of the Kratos applications.
  * Python3-dev
  * C++11 compiler
  * CMake
  * Boost (dependencies are header-only, no compilation of boost libraries required)

Additionaly, Visual Studio is required to compile in Windows.

- #### Linux installation

    The command below will install all the packages needed.

    ```Shell
    sudo apt-get install python3-dev gcc g++ cmake libboost-all-dev
    ```
    Newer versions of boost can be downloaded in:

    http://www.boost.org/users/download/.

- #### Windows installation

    - Visual Studio

        *Visual Studio* is the only compiler officially supported to build *Kratos* under *Windows*. The minimium required version is Visual Studio 2017, but we recommend to use Visual Studio 2019 or higher.

        * [Download Visual Studio](https://visualstudio.microsoft.com/en/thank-you-downloading-visual-studio/?sku=Community&rel=16)

        Since *Visual Studio* is a multi-language IDE, some distributions come without C++ compiler. Please, make sure that you can create a C++ project before continuing, in case C++ packages were missing you will be prompt to download them. You can install the **Desktop development with C++** workload with the Visual Studio Installer to acquire all necessary depencencies to compile C++ projects.

        When compiling Kratos in Windows, please take into consideration the [Windows Visual Studio compilation configuration](#Windows-Visual-Studio-compilation-configuration).

    - CMake
        * [Download CMake](http://cmake.org/download/)

        Once installing, please **do not forget to mark the option: '''"Add CMake to the system PATH for all users"'''**

        Minimum required version: CMake 3.14

    - Python

        You will need at least *Python* 3.5 (recommended 3.7/3.8) in your computer in order to compile *Kratos*. You can download python from its official webpage:

        * [Download Python](http://www.python.org/downloads/)

        Please, take special care to download a installer that suits your desired architecture **x86 for 32 bits**  compilations and **x86_64 for 64 bits**  compilations. Otherwise it won't work.

    - Boost

        The next step will consist in obtain Boost. *Kratos Multiphysics* needs *Boost* libraries to support some of its functions. You can use any version from `version 1.67` onward.

        * [Download Boost](http://www.boost.org/users/download/)

        Extract boost, and note the path as it will be needed in the configure stage to set the environmental variable `BOOST_ROOT`.


### Specific Application Dependencies

Some applications have additional dependencies. Please check the `README` files of the applications that are compiled

## Basic Configuration

You can find the new kratos configuration file in Kratos `scripts` folder: `standard_configure.sh` for linux, `standard_configure_max.sh` for MacOS, `standard_configure.bat` for win and others.

Out of the box Kratos will try to find all necessary libraries in your system automatically, but we recommend you to copy these scripts and modify it according to your preferences. Please take a look at the following configuration options:

`KRATOS_BUILD_TYPE`

Compilation Type. Options are `Release`,`RelWithDebInfo`,`Debug`,`FullDebug`,`Custom`

**Release**: Full Release with maximum optimization options and no debug Info.

**RelWithDebInfo**: Full Release with optimization and debug info. Adecuate to debug simple problems without losing performance.

**Debug**: Debug build with no optimization flags.

**FullDebug**: Debug build with no optimization flags, extended debug info and extremly low performance.

**Custom**: No flags are automatically added.

`PYTHON_EXECUTABLE`

Path to the python executable that Kratos will use. We recommend that you manually set this in case you have multiple versions of python in the system.
Ubuntu users need to be extra careful with this as default versions tends to be Python2, while Kratos is preferably compiled with Python3

`BOOST_ROOT`

Don't use this unless you have problems during the compilation. Path to boost root directory, set it if you downloaded but without using apt-get.

## Configuration scripts examples

These examples are also located [in the /scripts folder](https://github.com/KratosMultiphysics/Kratos/tree/master/scripts). You can simply create your own copy:

```Shell
cp /path_to_kratos/scripts/standard_configure.sh /path_to_kratos/scripts/configure.sh
```
Then, these scripts can be launched through the system terminal.

Linux

```Shell
sh /path_to_kratos/scripts/configure.sh
```

Windows

```Shell
./path_to_kratos/scripts/configure.bat
```
Note: after installing Visual Studio, in some Windows systems the console does not have direct access to the Visual Studio Compiler. In order to make sure the compiler is available, try typing 'cl'. Use this console to compile Kratos if the compiler responds. In case of error, instead of using the standard Windows console, open the Native Tools Command Prompt console and launch the compilation from there.

The example scripts for every system are shown next.

### Linux

```bash
# Function to add apps
add_app () {
    export KRATOS_APPLICATIONS="${KRATOS_APPLICATIONS}$1;"
}

# Set compiler
export CC=gcc
export CXX=g++

# Set variables
export KRATOS_SOURCE="${KRATOS_SOURCE:-"$( cd "$(dirname "$0")" ; pwd -P )"/..}"
export KRATOS_BUILD="${KRATOS_SOURCE}/build"
export KRATOS_APP_DIR="${KRATOS_SOURCE}/applications"
export KRATOS_INSTALL_PYTHON_USING_LINKS=ON

# Set basic configuration
export KRATOS_BUILD_TYPE="Release"
export PYTHON_EXECUTABLE="/usr/bin/python3"

# Set applications to compile
export KRATOS_APPLICATIONS=
add_app ${KRATOS_APP_DIR}/LinearSolversApplication
add_app ${KRATOS_APP_DIR}/StructuralMechanicsApplication
add_app ${KRATOS_APP_DIR}/FluidDynamicsApplication

# Clean
clear
rm -rf "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}/cmake_install.cmake"
rm -rf "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}/CMakeCache.txt"
rm -rf "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}/CMakeFiles"

# Configure
cmake -H"${KRATOS_SOURCE}" -B"${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" -DUSE_MPI=OFF -DUSE_EIGEN_MKL=OFF

# Buid
cmake --build "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" --target install -- -j4

```

### Windows

```cmd
rem Set compiler
set CC=cl.exe
set CXX=cl.exe

rem Set variables
set KRATOS_SOURCE=~0,-1%/..
set KRATOS_BUILD=%KRATOS_SOURCE%/build
set KRATOS_APP_DIR=applications

rem Set basic configuration
set KRATOS_BUILD_TYPE=Release
set BOOST_ROOT=C:\boost_1_67_0
set PYTHON_EXECUTABLE=C:\Python37\python.exe

rem Set applications to compile
set KRATOS_APPLICATIONS=
CALL :add_app %KRATOS_APP_DIR%\LinearSolversApplication;
CALL :add_app %KRATOS_APP_DIR%\StructuralMechanicsApplication;
CALL :add_app %KRATOS_APP_DIR%\FluidDynamicsApplication;

rem Clean
del /F /Q "%KRATOS_BUILD%\%KRATOS_BUILD_TYPE%\cmake_install.cmake"
del /F /Q "%KRATOS_BUILD%\%KRATOS_BUILD_TYPE%\CMakeCache.txt"
del /F /Q "%KRATOS_BUILD%\%KRATOS_BUILD_TYPE%\CMakeFiles"

rem Enable this if your build is slow and you have a multi-core machine
rem set KRATOS_PARALLEL_BUILD_FLAG=/MP4

rem Configure
@echo on
cmake -G"Visual Studio 16 2019" -H"%KRATOS_SOURCE%" -B"%KRATOS_BUILD%\%KRATOS_BUILD_TYPE%"  ^
-DUSE_EIGEN_MKL=OFF        ^
-DCMAKE_CXX_FLAGS=" %KRATOS_PARALLEL_BUILD_FLAG% "

rem Build
cmake --build "%KRATOS_BUILD%/%KRATOS_BUILD_TYPE%" --target install -- /property:configuration=%KRATOS_BUILD_TYPE% /p:Platform=x64
goto:eof

rem Function to add apps
:add_app
set KRATOS_APPLICATIONS=%KRATOS_APPLICATIONS%%1;
goto:eof

```
#### Windows Visual Studio compilation configuration

Some of the parameters detailed in the example script above may vary from system to system, or the Visual Studio version.

If you are using Visual Studio 2017, the configure command should be:
```
cmake -G"Visual Studio 15 2017" -H"%KRATOS_SOURCE%" -B"%KRATOS_BUILD%\%KRATOS_BUILD_TYPE%"  ^
-DUSE_EIGEN_MKL=OFF
```
You can check the specific Visual Studio version that you have installed in your system, by checking the Visual Studio Tab 'Help' > 'About Microsoft Visual Studio'.

If you have a 64-bit system, you might need to also specify it in the configure command for some Visual Studio versions with the flag ```-A x64```.

```
cmake -G"Visual Studio 15 2017" -A x64 -H"%KRATOS_SOURCE%" -B"%KRATOS_BUILD%\%KRATOS_BUILD_TYPE%"  ^
-DUSE_EIGEN_MKL=OFF
```




### MacOS

```bash
# Function to add apps
add_app () {
    export KRATOS_APPLICATIONS="${KRATOS_APPLICATIONS}$1;"
}

# Set compiler
export CC=/usr/local/opt/llvm/bin/clang
export CXX=/usr/local/opt/llvm/bin/clang++

# Set variables
export KRATOS_SOURCE="${KRATOS_SOURCE:-"$( cd "$(dirname "$0")" ; pwd -P )"/..}"
export KRATOS_BUILD="${KRATOS_SOURCE}/build"
export KRATOS_APP_DIR="${KRATOS_SOURCE}/applications"
export KRATOS_INSTALL_PYTHON_USING_LINKS=ON

# Set basic configuration
export KRATOS_BUILD_TYPE="Release"
export BOOST_ROOT="/path/to/boost"
export PYTHON_EXECUTABLE="/Library/Frameworks/Python.framework/Versions/3.7/bin/python3"

# Set applications to compile
export KRATOS_APPLICATIONS=
add_app ${KRATOS_APP_DIR}/LinearSolversApplication
add_app ${KRATOS_APP_DIR}/StructuralMechanicsApplication
add_app ${KRATOS_APP_DIR}/FluidDynamicsApplication

# Clean
clear
rm -rf "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}/cmake_install.cmake"
rm -rf "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}/CMakeCache.txt"
rm -rf "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}/CMakeFiles"

# Configure
/Applications/CMake.app/Contents/bin/cmake -H"${KRATOS_SOURCE}" -B"${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" \
 -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -msse3 -std=c++11 -L/usr/local/opt/llvm/lib" \
 -DCMAKE_C_FLAGS="${CMAKE_C_FLAGS} -msse3 -L/usr/local/opt/llvm/lib" \
 -DUSE_EIGEN_MKL=OFF

# Buid
/Applications/CMake.app/Contents/bin/cmake --build "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" --target install -- -j3

```

## Adding Applications

In order to add an application you can use the provided macro (`add_app [PATH]` for Linux, `CALL :add_app [PATH]` for Win) along with the route folder of the application that you want to compile. Several examples are provided in the configuration files.

Its now also possible to compile applications outside kratos source dir:

Linux:
```shell
add_app ${KRATOS_APP_DIR}/LinearSolversApplication
add_app ${KRATOS_APP_DIR}/FluidDynamicApplication
add_app /home/username/development/ExternalApplication  # Example of external Application
```

Windows:
```shell
CALL :add_app %KRATOS_APP_DIR%/LinearSolversApplication
CALL :add_app %KRATOS_APP_DIR%/FluidDynamicApplication
CALL :add_app C:/users/username/development/ExternalApplication  # Example of external Application
```

## Post Compilation

As Kratos is not an executable but a set of modules and libraries, you will need to add them to the path. In order to do that please add the Kratos install folder (If you didn't touch anything should be `$KRATOS_SOURCE/bin/Release`)

### Linux
```bash
export PYTHONPATH=$PYTHONPATH:$HOME/Kratos/bin/Release
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Kratos/bin/Release/libs
```
Or set them permanently by adding these lines in your *~/.bashrc*.

### Windows
In a *Command Prompt:*

```cmd
set PYTHONPATH=%PYTHONPATH%;C:/Kratos/bin/Release
set PATH=%PATH%;C:/Kratos/bin/Release/libs
```
In *Windows Powershell*:
```cmd
$Env:PYTHONPATH+=";C:/Kratos/bin/Release"
$Env:PATH+=";C:/Kratos/bin/Release/libs"
```

Or set them permanently using the  **Edit the system environment variables** option in the Control panel.

You can then test your compilation by executing an example script or trying to import the python module

```python
from KratosMultiphysics import *
```

The result should be:

```
   |  /           |
   ' /   __| _` | __|  _ \   __|
   . \  |   (   | |   (   |\__ \
  _|\_\_|  \__,_|\__|\___/ ____/
           Multi-Physics 8.0
```


## Advanced Configuration

### Parallel Compilation

We provide several flavours in order to parallelize Kratos compilation. We have divided this option according to the operating system specifics.

#### Linux

Linux builds should automatically make use of the maximum number of threads in your computer which is passed to the compiler in the `-j$(nproc)` flag on the last line of the configure file:
```
# Buid
cmake --build "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" --target install -- -j$(nproc)
```

If your linux flavour does not support the `$(nproc)` shortcut or you simply want to tune this value to some of your liking, you can change it:
```
# Buid (This will make it compile with 2 threads)
cmake --build "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" --target install -- -j2
```
**Warning**: Please be carefull while mixing parallel builds with unitay builds. See [below](#unitary-builds)

#### Windows

Windows should detect automatically the number of threads of your computer, but many times this mechanism fails. We included several options in order to force the parallel compilation:

You can force it manually by commenting this lines in the configuration file, and adding a number of processes of your choice:
```ps1
rem Enable this if your build is slow and you have a multi-core machine
rem set KRATOS_PARALLEL_BUILD_FLAG=/MPX
```

This will pass the `/MPX` option directly to `CL.exe`, where `X` is the number of threads you want to use.

If you preffer to interact directly with `MSBuild.exe` you can use either of this options in the cmake build command:
- `/p:CL_MPcount=X`: Enable multiples cpp to be compiled in parallel
- `/m:x`: Enable multiple applications to be compiled in parallel

Example using 4 threads and a single project
```ps1
rem Build
cmake --build "%KRATOS_BUILD%/%KRATOS_BUILD_TYPE%" --target install -- /property:configuration=%KRATOS_BUILD_TYPE% /p:Platform=x64 /p:CL_MPcount=4 /m:1
```

Example using 2 threads and 2 project ( total io 4 threads )
```ps1
rem Build
cmake --build "%KRATOS_BUILD%/%KRATOS_BUILD_TYPE%" --target install -- /property:configuration=%KRATOS_BUILD_TYPE% /p:Platform=x64 /p:CL_MPcount=2 /m:2
```

Finally you can set parallelism options in the VisualStudio IDE.

**Warning**: Please be careful while mixing parallel builds with unitary builds. See [below](#unitary-builds)

#### MacOS

There is no dedicated support for parallel builds in MacOS, but Linux options should behave very similarly. If you detect a problem please inform us and we will
try to update this section with the specifics.

### Building Environment

It is possible to configure the build environment for Kratos, that is: where the source is located, which will be the install dir, and how the python files are going to be installed.

`KRATOS_SOURCE=Path`

Path to the source of Kratos. It will target the directory above this script by default.

`KRATOS_BUILD=Path`

Build directory for Kratos. Makefiles, vsprojects and other artifacts will be stored here. It defaults to Kratos/Build

`KRATOS_APP_DIR=Path`

Path where your applications are located. This variable is not necessary but it helps to organize the list of applications to be compiled. It defaults to Kratos/Applications

`KRATOS_INSTALL_PYTHON_USING_LINKS=ON/OFF`

Controls wether the python files are installed by making copies or creating symlinks to the files in the source directory. This options is specially usefull if you are developing python files and don't want to reinstall every time you touch a script.

Using this option in windows requires elevated privileges (you must run the script as admin)


### Common Flags

It is also possible to use more advanced configuration options. To use any of these options please add them directly to the cmake configuration line just as any other flag


`-DCMAKE_C_COMPILER=String`

Path to the C compiler. Overrides `CC` environment variable

`-DCMAKE_CXX_COMPILER=String`

Path to the C++ compiler. Overrides `CXX` environment variable

`-DCMAKE_INSTALL_PREFIX=String`

Install path for Kratos. If not set the installation will be done in `bin/[build_type]`

`-DCMAKE_C_FLAGS=String`

User defined flags for the C compiler.

`-DCMAKE_CXX_FLAGS=String`

User defined flags for the C++ compiler.

`-DBOOST_ROOT=String`

Root directory for boost. Overrided by BOOST_ROOT environmental variable if defined.

`-DPYTHON_EXECUTABLE=String`

Python executable to be used. It is recommended to set this option if more than one version of python is present in the system (For example while using ubuntu). Overrided by PYTHON_EXECUTABLE environmental variable if defined.

`-DINSTALL_RUNKRATOS=ON/OFF`

Enables(Default) or Disables the compilation of the embedded python interpreter (aka Runkratos).

`-DKRATOS_BUILD_TESTING=ON/OFF`

Enables(Default) or Disables the compilation of the C++ unitary tests for Kratos and Applications.

### Unitary Builds
`-DCMAKE_UNITY_BUILD=ON/OFF`

Enables or Disables(default) the use of [cmake unity build](https://cmake.org/cmake/help/latest/prop_tgt/UNITY_BUILD.html) to speedup compilation by using unitary builds.
Please notice that enabling this options can greatly increase the amount of memory needed to compile some targets, specially if combined with -jx.

In order to install and compile with this switch please use:

On Linux
```shell
cmake --build "${KRATOS_BUILD}/${KRATOS_BUILD_TYPE}" --target install -- -j1
```
On Windows
```shell
cmake --build "%KRATOS_BUILD%/%KRATOS_BUILD_TYPE%" --target install -- /property:configuration=%KRATOS_BUILD_TYPE% /p:Platform=x64
```

Instead of the regular install target.

Please, beware that using this flag along with a parallel compilation may cause a VERY LARGE use of ram as we hardcoded Kratos compilation so unitary builds try to make as many unitary targets as threads are usable
We recommed you to disable parallel compilation unless you know what you are doing.

### Parallelism
`-DUSE_MPI=ON/OFF`

Enables or Disables(default) the modules and code for mpi. This option is needed if you want to compile Trilinos, Metis, etc...

### Logging
`-DKRATOS_COLORED_OUTPUT=ON/OFF`

Enables colored output of the Logger. If switched on, e.g. warning level messages will be printed in yellow to the terminal. Please notice that colored output is not supported by all terminals.

### TPL-Libraries
Kratos can make use of TPL libraries that cannot be included in the main compilation processes for a variety of reasons
If you want to add support for those libraries, we provide switches to enable them.

Please note that **Kratos will NEVER DISTRIBUTE, RELEASE or COMPILE** with these libraries unless explicitly specified, and the use of these libraries may add additional restrictions on top of BSD.

#### Tetgen
[Tetgen](http://wias-berlin.de/software/tetgen/) is a library to generate tetrahedral meshes. We provide some utilities that can make use of tetgen. The flags related with Tetgen are the following:

`-DUSE_TETGEN_NONFREE_TPL=ON`
Enables/Disables the use of tetgen and its related utilities in the code. If no other options provided Kratos will try to find tetgen installed on your system.

`-DUSE_TETGEN_NONFREE_TPL_PATH="${TETGEN_PATH}"`
Tries to use a local version of tetgen from a given `TETGEN_PATH`

`-DUSE_TETGEN_NONFREE_TPL_URL="${TETGEN_URL}"`
Tries to download and use a version of tetgen from a given `TETGEN_URL`

`-DFORCE_TETGEN_NONFREE_TPL_URL`
Forces to re-download and replace an existing version of tetgen obtained through `USE_TETGEN_NONFREE_TPL_URL`

#### Triangle
[Triangle](http://www.cs.cmu.edu/~quake/triangle.html) is a library for delaunay triangulation. We provide some utilities in Kratos that depend on this library. The flags related with Triangle are the following:

`-DUSE_TRIANGLE_NONFREE_TPL`
Enables or disables the use of Triangle and its related utilities in the code.
