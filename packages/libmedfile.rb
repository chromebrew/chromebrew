require 'buildsystems/cmake'

class Libmedfile < CMake
  description 'libmedfile is a library to store and exchange meshed data or computation result in MED format.'
  homepage 'https://www.salome-platform.org/'
  version '6.0.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://files.salome-platform.org/Salome/medfile/med-#{version}.tar.gz"
  source_sha256 'f8f1edc6874bc48d8f3e4e8be1cf7379ed318726d8abc6804e85e821555b1fa8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a24991c095e78f249d9f31a261f4b9c397917aa35aab2d3f2d907ad1bcd94e5',
     armv7l: '6a24991c095e78f249d9f31a261f4b9c397917aa35aab2d3f2d907ad1bcd94e5',
       i686: 'd31d41847c509c9a73e78ac6d0c113da1aa76f1e11e6324c8fb4e0e01e3d8eba',
     x86_64: '3edce1f7b0b47d1bf4b1fdbc8da083aadb1c5d0ee80cce42833eac4e652853fa'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'hdf5' => :library

  # TODO: This is not ideal, because hdf5 does not install its cmake detection files in a subdirectory
  # The entire medfile library situation is more complicated than it should be, and its possible there is a more updated
  # version of libmedfile that supports hdf5 2.x, which might have better installation directory path options.
  cmake_options "-DHDF5_ROOT_DIR=#{CREW_PREFIX}/lib#{CREW_LIB_SUFFIX}/cmake"
end
