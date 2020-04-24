cmake_minimum_required(VERSION 3.0)
set(CMAKE_SYSTEM_NAME vxworks)
set(CMAKE_SYSTEM_VERSION 7)
SET(VXWORKS 1)


#get target architecture
#it's ugly but if you can do better, show me!
execute_process(COMMAND wr-cc -v ERROR_VARIABLE TARGET_ARCH)
string(REGEX MATCH "Target: [^\n]*" TARGET_ARCH ${TARGET_ARCH})
string(REPLACE "Target: " "" TARGET_ARCH ${TARGET_ARCH})


set(CMAKE_SYSTEM_PROCESSOR ${TARGET_ARCH})


#workaround to se proper vxworks module suffix
set(PYTHON3_CVPY_SUFFIX ".cpython-38-vxworks.so")


set(CMAKE_GENERATOR "Unix Makefiles")
set(CMAKE_MAKE_PROGRAM "/usr/bin/make" CACHE INTERNAL "" FORCE)

set(CMAKE_CROSSCOMPILING TRUE)

set(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-Wl,-soname=")

set(CMAKE_LINKER       wr-ld CACHE INTERNAL "" FORCE)
set(CMAKE_AR           wr-ar CACHE INTERNAL "" FORCE)
set(CMAKE_C_COMPILER   wr-cc)
set(CMAKE_CXX_COMPILER wr-c++)

set(CMAKE_FIND_ROOT_PATH $ENV{WIND_SDK})
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)



set(CMAKE_CXX_FLAGS           "-I${CMAKE_BINARY_DIR} -I${CMAKE_SOURCE_DIR}/3rdparty/protobuf/src -DGOOGLE_PROTOBUF_HAS_CXX11_HASH ${CMAKE_CXX_FLAGS}"  CACHE INTERNAL "" FORCE)
set(CMAKE_C_FLAGS             "-I${CMAKE_BINARY_DIR} -I${CMAKE_SOURCE_DIR}/3rdparty/protobuf/src -DGOOGLE_PROTOBUF_HAS_CXX11_HASH ${CMAKE_C_FLAGS}"  CACHE INTERNAL "" FORCE )

#Forcing options that are irrelevant for vxWorks OFF

set(BUILD_opencv_java OFF  CACHE INTERNAL "" FORCE)
set(OPENCL_FOUND OFF  CACHE INTERNAL "" FORCE)
set(OPENCV_DNN_OPENCL OFF  CACHE INTERNAL "" FORCE)
set(WITH_1394 OFF  CACHE INTERNAL "" FORCE)
set(WITH_ADE OFF  CACHE INTERNAL "" FORCE)
set(WITH_ARITH_DEC OFF  CACHE INTERNAL "" FORCE)
set(WITH_ARITH_ENC OFF  CACHE INTERNAL "" FORCE)
set(WITH_FFMPEG OFF  CACHE INTERNAL "" FORCE)
set(WITH_OPENJPEG OFF CACHE INTERNAL "" FORCE)
set(WITH_GSTREAMER OFF  CACHE INTERNAL "" FORCE)
set(WITH_IMGCODEC_PFM OFF  CACHE INTERNAL "" FORCE)
set(WITH_IMGCODEC_PXM OFF  CACHE INTERNAL "" FORCE)
set(WITH_IMGCODEC_HDR OFF  CACHE INTERNAL "" FORCE)
set(WITH_IMGCODEC_SUNRASTER OFF  CACHE INTERNAL "" FORCE)
set(WITH_ITT OFF  CACHE INTERNAL "" FORCE)
set(WITH_JASPER OFF  CACHE INTERNAL "" FORCE)
set(WITH_LAPACK OFF  CACHE INTERNAL "" FORCE)
set(WITH_OPENCL OFF  CACHE INTERNAL "" FORCE)
set(WITH_OPENCLAMDBLAS OFF  CACHE INTERNAL "" FORCE)
set(WITH_OPENCLAMDFFT OFF  CACHE INTERNAL "" FORCE)
set(WITH_OPENEXR OFF  CACHE INTERNAL "" FORCE)
set(WITH_QUIRC OFF  CACHE INTERNAL "" FORCE)
set(WITH_TIFF OFF  CACHE INTERNAL "" FORCE)
set(WITH_WEBP OFF  CACHE INTERNAL "" FORCE)
set(WITH_EIGEN OFF  CACHE INTERNAL "" FORCE)
set(WITH_GTK OFF  CACHE INTERNAL "" FORCE)
set(WITH_VTK OFF CACHE INTERNAL "" FORCE )
set(WITH_CAROTENE OFF CACHE INTERNAL "" FORCE)

#Intrinsics issues for arm build also disabling FP16 for raspberry pi
if (TARGET_ARCH MATCHES "arm64")
    set(CV_ENABLE_INTRINSICS OFF CACHE INTERNAL "" FORCE )
    set(HAVE_CPU_FP16_SUPPORT OFF CACHE INTERNAL "" FORCE )
endif()


set(HAVE_PTHREAD ON CACHE INTERNAL "" FORCE)

#PYTHON
set(BUILD_OPENCV_PYTHON2 OFF CACHE INTERNAL "" FORCE)
set(PYTHON_EXECUTABLE /usr/bin/python3.8)
set(PYTHON3_INCLUDE_PATH $ENV{WIND_SDK_TOOLKIT}/include/usr/3pp/deploy/usr/include/python3.8)
set(PYTHON3_LIBRARIES  $ENV{WIND_SDK_TOOLKIT}/include/usr/3pp/deploy/usr/lib/libpython3.8.a)
set(PYTHON3_NUMPY_INCLUDE_DIRS  $ENV{WIND_SDK_TOOLKIT}/include/usr/3pp/deploy/usr/lib/python3.8/site-packages/numpy-1.18.1-py3.8-linux-x86_64.egg/numpy/core/include)
set(PYTHON3_PACKAGES_PATH lib/python3.8/site-packages)
