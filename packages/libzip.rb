require 'buildsystems/cmake'

class Libzip < CMake
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.11.4'
  license 'BSD'
  compatibility 'all'
  source_url "https://libzip.org/download/libzip-#{version}.tar.xz"
  source_sha256 '8a247f57d1e3e6f6d11413b12a6f28a9d388de110adc0ec608d893180ed7097b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf53b740f331983c09489712055203ff758c0dd8beaa1f84c5b5213d646d92f8',
     armv7l: 'bf53b740f331983c09489712055203ff758c0dd8beaa1f84c5b5213d646d92f8',
       i686: 'be6a5375a64f5ca4075c52268be1392f16c10f76faf2146a5f15843063a946bb',
     x86_64: 'c7478e3c8f23747e674c03a0205a191dea0725f7013177d1edee1506b26af2bf'
  })

  depends_on 'bzip2' => :library
  depends_on 'glibc' => :library
  depends_on 'libmbedtls' => :library
  depends_on 'openssl' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library
end
