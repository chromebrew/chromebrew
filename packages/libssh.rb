require 'buildsystems/cmake'

class Libssh < CMake
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.10.5'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{version.rpartition('.')[0]}/libssh-#{version}.tar.xz"
  source_sha256 'b60e2ff7f367b9eee2b5634d3a63303ddfede0e6a18dfca88c44a8770e7e4234'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.5_armv7l/libssh-0.10.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.5_armv7l/libssh-0.10.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.5_i686/libssh-0.10.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.5_x86_64/libssh-0.10.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '035d003c9c829f069844cc16d7ec513a91be550d951ec2e079e18d1ebefa5561',
     armv7l: '035d003c9c829f069844cc16d7ec513a91be550d951ec2e079e18d1ebefa5561',
       i686: '8f3429e3e842d0f34b1fe5ef1b0f4c80fc5b7f37ee655b000059e77925fb08e9',
     x86_64: 'a5f75c8210732d9937f7897768efd50d12cd3b96ab1cc2988bacd77a3d9107d1'
  })

  depends_on 'e2fsprogs'
  depends_on 'krb5'
  depends_on 'libgcrypt'
  depends_on 'py3_abimap' => :build
  depends_on 'zlibpkg'
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  cmake_options '-DWITH_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
