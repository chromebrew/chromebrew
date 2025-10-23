require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.2p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e14a79589cb3c738770a6e3d03019d1c880b0030bde68004d2779a5afea21de',
     armv7l: '9e14a79589cb3c738770a6e3d03019d1c880b0030bde68004d2779a5afea21de',
       i686: 'c7836dcdad15a429d57e9825f55a983fcc5066a6a038c4749348891a7913879e',
     x86_64: '4b5ea1a24f307f040e3e6a4d6f59b0490887faa8431126a045e0ddfb30095687'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'libxcrypt' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
