require 'buildsystems/cmake'

class Libssh < CMake
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.12.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{version.rpartition('.')[0]}/libssh-#{version}.tar.xz"
  source_sha256 '49560f677d96e3706a904ac2de1116e25f3680937d51e5c92198fcba4a1c1e9f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1ce0ccc906d645b46e23cf3a6148c7cb0942ad0719d3df537ab3ad7404d39d4',
     armv7l: 'a1ce0ccc906d645b46e23cf3a6148c7cb0942ad0719d3df537ab3ad7404d39d4',
       i686: 'd58af93838e9d513b4a78561e8d11c68407e17a7e19d996bad76db23b0bf0a29',
     x86_64: '9af5f8cee15d07834877fadbf4b9fb6013f38def0b25dc684e795a09e3a8f197'
  })

  depends_on 'e2fsprogs' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'krb5' => :library
  depends_on 'libgcrypt'
  depends_on 'openssl' => :library
  depends_on 'py3_abimap' => :build
  depends_on 'zlib' => :library

  cmake_options '-DWITH_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
