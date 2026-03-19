require 'buildsystems/cmake'

class Hdf5 < CMake
  description 'HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections.'
  homepage 'https://www.hdfgroup.org/'
  version '1.14.6' # Do not update to 2.x branch, it will break libmedfile.
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/HDFGroup/hdf5.git'
  git_hashtag "hdf5-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5c211e8278e2131b8a075a28cbe5fba446da9ca514d15b915a8c997384bcd6d',
     armv7l: 'b5c211e8278e2131b8a075a28cbe5fba446da9ca514d15b915a8c997384bcd6d',
       i686: '75b553e5aaa69e029fc6446d92c7bf45aea8d6ffb884ada875cfbf2d4b006f28',
     x86_64: '79fc2b988f6b8de1bb0ff1b0a9f53dc22bd95158bb1e2447be2a2ef67691970c'
  })

  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  cmake_options '-DHDF5_USE_GNU_DIRS=ON'
end
