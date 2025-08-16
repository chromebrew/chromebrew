require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.0p2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80432e72eff4e6bd25c4b5030e6bc7514fde4a5ae4253958cd83e3064cf90a96',
     armv7l: '80432e72eff4e6bd25c4b5030e6bc7514fde4a5ae4253958cd83e3064cf90a96',
       i686: 'a1564055bc0b85523cfe7c241f7f8844af2e30dfee12bb50292af3df93cf79e4',
     x86_64: '35ebb267980e512889c0a5add625cbf4f8dc09e4ef3e5e6a49de43f55b250cfc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'libxcrypt' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
