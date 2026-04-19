require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.2.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '5b5f505acef9bfd8ca78b698378a206b12abe8981851b61ae8964fb92b100f36'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16d79f0911e9aff908bbce24c8f4e67868e770d363c3b9bf09ceedbf059bc535',
     armv7l: '16d79f0911e9aff908bbce24c8f4e67868e770d363c3b9bf09ceedbf059bc535',
       i686: 'e906b9a39ba6772901116abe6b9192c11481ad96197adcad5b6fd76d76e2e188',
     x86_64: '1f4bf25ea3c18194b72f223130b59fc5ff71b9d6dbeabcfb8d60fff298395ae0'
  })

  depends_on 'arpack_ng' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'hdf5' => :build
  depends_on 'lapack' => :library
  depends_on 'openblas' => :library
  depends_on 'superlu' => :library

  cmake_options "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{'64' if ARCH == 'x86_64'}.so"
end
