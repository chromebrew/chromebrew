require 'buildsystems/cmake'

class Libssh < CMake
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.12.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{version.rpartition('.')[0]}/libssh-#{version}.tar.xz"
  source_sha256 '1a6af424d8327e5eedef4e5fe7f5b924226dd617ac9f3de80f217d82a36a7121'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1fe6e96a206d48b1e03d66fb4a67d0d2dbf404196193431f8df3b05a0ab7090',
     armv7l: 'c1fe6e96a206d48b1e03d66fb4a67d0d2dbf404196193431f8df3b05a0ab7090',
       i686: 'fbae318ec918b543457b79e3829378893aee681cc45c5941f3a1764e099d77ab',
     x86_64: 'f2ecdefbe948d1a90940c2f90e0d24b9fc6c7cbcd101280cd0e212c2c5a85dd6'
  })

  depends_on 'e2fsprogs'
  depends_on 'glibc' # R
  depends_on 'krb5'
  depends_on 'libgcrypt'
  depends_on 'openssl' # R
  depends_on 'py3_abimap' => :build
  depends_on 'zlib'

  cmake_options '-DWITH_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
