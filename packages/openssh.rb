require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.9p2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '').chars[0...-1].join('_') + version.chars.pop}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32a5edc94e2df7e317e941b60c0b47c618a8ea7723888574a2c8fe75b9995899',
     armv7l: '32a5edc94e2df7e317e941b60c0b47c618a8ea7723888574a2c8fe75b9995899',
       i686: '379eb8f21ad4280d5623a915eff39995430ba438ff0a5524e41de71a734124b5',
     x86_64: 'e6975c01eab21dfdbad69e1db39574a2386a65703cb309fc69cd36a0446584de'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
