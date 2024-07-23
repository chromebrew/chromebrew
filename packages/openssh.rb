require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.8p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_8_P1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f34e1cb3b2f851183e605ed793f7f0d2c948825e957de5668565562cee9dd713',
     armv7l: 'f34e1cb3b2f851183e605ed793f7f0d2c948825e957de5668565562cee9dd713',
       i686: '8ec26067d3074d2ac4f33048d6a41d36d89d17c5d81c98b0ff7d61377db03807',
     x86_64: '96834677981dbb55fb51ed1e99d9abe9d8121629702d4b84cb01dd3926b65e77'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
