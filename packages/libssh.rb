require 'buildsystems/cmake'

class Libssh < CMake
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.12.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{version.rpartition('.')[0]}/libssh-#{version}.tar.xz"
  source_sha256 'd3941af0a2d78d5d82ed7a36988e9133994312f035b9659a6e43f8db3968784c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5258ae011dbbb5daf9efa2370bdd477da6b0aba4417805b780b72eb6fb464ade',
     armv7l: '5258ae011dbbb5daf9efa2370bdd477da6b0aba4417805b780b72eb6fb464ade',
       i686: '698c33a0213b80a0a3d01ac0c6954b479be2d4834b257492e7712999d4e3b696',
     x86_64: '5eac0aa0860fe4034708f568f0761c17bedffd56e73dd448ed24c5a6f2fe0e68'
  })

  depends_on 'e2fsprogs' => :library
  depends_on 'glibc' => :library
  depends_on 'krb5' => :library
  depends_on 'libgcrypt'
  depends_on 'openssl' => :library
  depends_on 'py3_abimap' => :build
  depends_on 'zlib' => :library

  cmake_options '-DWITH_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
