require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.6p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_6_P1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_armv7l/openssh-9.6p1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_armv7l/openssh-9.6p1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_i686/openssh-9.6p1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.6p1_x86_64/openssh-9.6p1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2febf81fb6e0482dee87b45b07b81b5f279e94a041678cba8892cf604aa6858b',
     armv7l: '2febf81fb6e0482dee87b45b07b81b5f279e94a041678cba8892cf604aa6858b',
       i686: 'b7eaed3ee4f3a46a8a1b1b4e76715afd203c9688c252231d58c7c6bff1c2255d',
     x86_64: '5284f191b28997c52b952cddf703d1ae0b65ca080052ac0d5a5002887a5f41cf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--without-hardening'
end
