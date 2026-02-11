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
    aarch64: 'ea15d2dadc46d44f5b28bd1674f8ea3048e3a4f19d3c8f4aa7a1c1988d800e71',
     armv7l: 'ea15d2dadc46d44f5b28bd1674f8ea3048e3a4f19d3c8f4aa7a1c1988d800e71',
       i686: 'b0798ef1a974e9b96fbbcadd7481df2e6fc7f16be203fc80fc581c99752ba5db',
     x86_64: '3a3f9eb8a3fa873d0a10a3a53fbe4fd21c21a819339eda171535e23c2833c077'
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
