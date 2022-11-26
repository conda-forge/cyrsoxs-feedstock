setlocal EnableDelayedExpansion
echo on

mkdir build
cd build
echo "In build, running Cmake"
cmake -G "NMake Makefiles" ^
	-DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
	-DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
  	-DCMAKE_BUILD_TYPE:STRING="Release" ^
	-DCMAKE_CUDA_HOST_COMPILER:PATH="%CXX%" ^
  	${CMAKE_PLATFORM_FLAGS[@]} ^
	${CMAKE_ARGS} ^
        ..

if errorlevel 1 exit 1
echo "running nmake"
nmake
if errorlevel 1 exit 1
echo "running nmake install"
nmake install
if errorlevel 1 exit 1
cd ../

mkdir build-pybind
cd build-pybind
cmake -G "NMake Makefiles" ^
	-DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
	-DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
  	${CMAKE_ARGS} ^
  	-DCMAKE_BUILD_TYPE:STRING="Release" ^
  	-DPYBIND=Yes ^
 	-DUSE_SUBMODULE_PYBIND=No ^
 	-DPython_EXECUTABLE="%PYTHON%"  ^
  	${CMAKE_PLATFORM_FLAGS[@]} ^
  	-DCMAKE_CUDA_RUNTIME_LIBRARY:STRING="Shared" ^
	-DCMAKE_CUDA_HOST_COMPILER:PATH="%CXX%" ^
	.. 
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
cd ../
