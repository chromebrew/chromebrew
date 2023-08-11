require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.4p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_4_P1'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.4p1_i686/openssh-9.4p1-chromeos-i686.tar.zst',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.4p1_armv7l/openssh-9.4p1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.4p1_armv7l/openssh-9.4p1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.4p1_x86_64/openssh-9.4p1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: '52afc47da42cb9781d834ac1a2ba5d80bcb59d477814a8e712507c0d4f2777dc',
    aarch64: '5b2b1f607dc197dacf61f2c18ee94d7945b04bfffef2a5d0d6f13e9accf75e33',
     armv7l: '5b2b1f607dc197dacf61f2c18ee94d7945b04bfffef2a5d0d6f13e9accf75e33',
     x86_64: '559fd33ad76b3077a8bb7073406a80bbc8cbf89eafa1a77b6e1d70902d6f04fb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--without-hardening'
end
