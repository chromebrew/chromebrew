require 'buildsystems/cmake'

class Hdf5 < CMake
  description 'HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections.'
  homepage 'https://www.hdfgroup.org/'
  version '2.2.0' # Do not update to 2.x branch, it will break libmedfile.
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/HDFGroup/hdf5.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dac2b0cd6a6372327e8794f239030ffc9144d1ed2d38c582cfbd7484793ec39d',
     armv7l: 'dac2b0cd6a6372327e8794f239030ffc9144d1ed2d38c582cfbd7484793ec39d',
       i686: '07e984aa67b72578d5b90448813b55f18549e86e98152036e4b18cccaf7e0e6b',
     x86_64: '09eb749b46179d3282f89e2c821cb295e32ab187b403cb5521a2e13eb758b21d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libaec' => :library
  depends_on 'zlib' => :library

  cmake_options '-DHDF5_USE_GNU_DIRS=ON'
end
