require 'buildsystems/cmake'

class Hdf5 < CMake
  description 'HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections.'
  homepage 'https://www.hdfgroup.org/'
  version '1.14.6' # Do not update to 2.x branch, it will break libmedfile.
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/HDFGroup/hdf5.git'
  git_hashtag "hdf5_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b36432a244407f7e868b38659297c02901f1d119828361d6a6c9747272c950c4',
     armv7l: 'b36432a244407f7e868b38659297c02901f1d119828361d6a6c9747272c950c4',
       i686: 'df6cddf4185bfb30ea7a2a82f984405f0e6d5bff2b48920f8639fa18cfd47acf',
     x86_64: 'a1c6fcfbaa3b18530dd622244f84d52b31bcbaac433d8c15618c38b0ed12131f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libaec' => :library
  depends_on 'zlib' => :library

  cmake_options '-DHDF5_USE_GNU_DIRS=ON'
end
