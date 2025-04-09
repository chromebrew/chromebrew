require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.0p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d1c5d5a61c18ecb5804739ed3ecd2738c79db33d8d596222161d12e984c626c',
     armv7l: '6d1c5d5a61c18ecb5804739ed3ecd2738c79db33d8d596222161d12e984c626c',
       i686: 'b785e24f70d5f3370ede5809d0129e97075118992ebd709b6e219da1202a7f8a',
     x86_64: 'bc67ebc6e34c0fcf84f871940f2cdbf8b0255761c2e48a594336c7788694076d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
