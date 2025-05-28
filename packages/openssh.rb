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
    aarch64: '13391d7f849c21a1033b8e004968f9dc6a57de07bdbc95f00207b1c2b90a97ae',
     armv7l: '13391d7f849c21a1033b8e004968f9dc6a57de07bdbc95f00207b1c2b90a97ae',
       i686: 'b785e24f70d5f3370ede5809d0129e97075118992ebd709b6e219da1202a7f8a',
     x86_64: '5f9cc255df55c9a63582068aaacc60a3bcffd953fa9a62c48218e61ce8745e97'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
