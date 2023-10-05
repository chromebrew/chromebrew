require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.5p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_5_P1'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.5p1_i686/openssh-9.5p1-chromeos-i686.tar.zst',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.5p1_armv7l/openssh-9.5p1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.5p1_armv7l/openssh-9.5p1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.5p1_x86_64/openssh-9.5p1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: 'bdb0ed63cf5def0fcddce9353cc1685af9adf3a7cc989197b8321a64f80fb129',
    aarch64: 'd78d84daeeb728cc8ca5df99777b5b84ff14ffb46c04b58e0a673f3bc8ba91ef',
     armv7l: 'd78d84daeeb728cc8ca5df99777b5b84ff14ffb46c04b58e0a673f3bc8ba91ef',
     x86_64: 'b2ba793087a80bd9e24b4571be43eeb3e65bdeae75a0fa687cabd8fef8552278'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--without-hardening'
end
