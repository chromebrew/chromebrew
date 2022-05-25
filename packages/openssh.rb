require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.6p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_6_P1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_armv7l/openssh-9.6p1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_armv7l/openssh-9.6p1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_i686/openssh-9.6p1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_x86_64/openssh-9.6p1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '56ba02dfb90234a579ad2625cc8a6acd58257f0160d35c3d34150b0eb3abca05',
     armv7l: '56ba02dfb90234a579ad2625cc8a6acd58257f0160d35c3d34150b0eb3abca05',
       i686: 'ac1f4567a4a85a11cae2ce9f6ca1b7824871f02469b706d418aa85e5f223e206',
     x86_64: 'e500485d26540eb8236543d1710c807ff35fe43dad406f1304b5bd9a37e27ea8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--without-hardening'
end
