require 'buildsystems/cmake'

class Libssh < CMake
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.11.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{version.rpartition('.')[0]}/libssh-#{version}.tar.xz"
  source_sha256 'b60e2ff7f367b9eee2b5634d3a63303ddfede0e6a18dfca88c44a8770e7e4234'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '035d003c9c829f069844cc16d7ec513a91be550d951ec2e079e18d1ebefa5561',
     armv7l: '035d003c9c829f069844cc16d7ec513a91be550d951ec2e079e18d1ebefa5561',
       i686: '709cac8b5e0a2419926b68614fc82aeae01ea7189f9ffd5619e440fe08b1a0f8',
     x86_64: 'c05854fe1214aa1f962f7080493da80d081e02c54336de81100fd84efdd5216d'
  })

  depends_on 'e2fsprogs'
  depends_on 'krb5'
  depends_on 'libgcrypt'
  depends_on 'py3_abimap' => :build
  depends_on 'zlib'
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  cmake_options '-DWITH_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
