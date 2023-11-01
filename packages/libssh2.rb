require 'buildsystems/autotools'

class Libssh2 < Autotools
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.11.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.libssh2.org/download/libssh2-1.11.0.tar.gz'
  source_sha256 '3736161e41e2693324deb38c26cfdc3efe6209d634ba4258db1cecff6a5ad461'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.11.0_armv7l/libssh2-1.11.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.11.0_armv7l/libssh2-1.11.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.11.0_i686/libssh2-1.11.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh2/1.11.0_x86_64/libssh2-1.11.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a7fa2cb89d69242f3a961563e0d3a2de115e5b2a1a2314669c93506105f723a8',
     armv7l: 'a7fa2cb89d69242f3a961563e0d3a2de115e5b2a1a2314669c93506105f723a8',
       i686: '278b8c6b59c297009e6e964672f0b73166a0f7636401f0f365ed38f736b5a629',
     x86_64: 'f1b86b658c3fb8dfc91f89d6800eafc0662e43d6692c68bf56ae6b1f4f655e62'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--with-libz'
end
