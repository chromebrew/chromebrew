require 'buildsystems/cmake'

class Libzip < CMake
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.12.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://libzip.org/download/libzip-#{version}.tar.xz"
  source_sha256 'c40062022a1963c80573d48f6070792297cecd7c6bffe3aefcac0d8b9bee8913'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2cfd4c6a5a810fc1dc750a364395737525249fc283c9a5ecf74936b5d436ed4',
     armv7l: 'd2cfd4c6a5a810fc1dc750a364395737525249fc283c9a5ecf74936b5d436ed4',
       i686: 'cb3376e76b687f4ed44ea45909828f3cee3a126177149fd1c926d0ea904fb5ee',
     x86_64: '2e0d797864b4d441c8c6a97f4c1298f5c281d4337486b7553333e92b9faa32ff'
  })

  depends_on 'bzip2' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libmbedtls' => :library
  depends_on 'openssl' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library
end
