require 'buildsystems/cmake'

class Arpack_ng < CMake
  description 'Collection of Fortran77 subroutines designed to solve large scale eigenvalue problems.'
  homepage 'https://github.com/opencollab/arpack-ng'
  version '3.9.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/opencollab/arpack-ng.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31b13ca1dc12f0dca520d465bcfa2feb74178de8bc3d0a9d54029f6a528bc252',
     armv7l: '31b13ca1dc12f0dca520d465bcfa2feb74178de8bc3d0a9d54029f6a528bc252',
       i686: '329aa907033b425be2bbc27665b284b091d7a20461898125813a1d972be4b02a',
     x86_64: '4b858a509a4084b5711d6f2a132bb11dfb7da0e2291c0501425ca61449256548'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lapack' => :library
  depends_on 'openblas' => :library
  depends_on 'openmpi' => :library

  cmake_options " \
    -DBLAS_LIBRARIES=#{CREW_LIB_PREFIX}/libopenblas.so \
    -DCMAKE_Fortran_COMPILER=#{CREW_PREFIX}/bin/gfortran \
    -DCMAKE_Fortran_FLAGS=-I#{CREW_PREFIX}/include \
    -DINTERFACE64=#{ARCH.eql?('x86_64') ? 'ON' : 'OFF'} \
    -DMPI=#{ARCH.eql?('x86_64') ? 'OFF' : 'ON'} \
    -DMPI_Fortran_WORKS=ON \
    -DLIBSUFFIX=#{'64' if ARCH.eql?('x86_64')} \
    -DBUILD_SHARED_LIBS=ON \
    -DEXAMPLES=OFF \
    -DTESTS=OFF \
    -DICB=ON"
end
