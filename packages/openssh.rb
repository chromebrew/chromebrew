require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.6p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '511f15dc60681797f9875c42a40d9e1570a4c927115aaee636dbd3146c7c7e5b',
     armv7l: '511f15dc60681797f9875c42a40d9e1570a4c927115aaee636dbd3146c7c7e5b',
       i686: 'e138ada97364d09addf0f1ed33d8115d96eedc04667fe8ade3bb07a2da2d7704',
     x86_64: 'd03761983ee6f9731b57600eefe0a5a4c666aa7a4d2b889dfec3251af45a6fa5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libmd' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'libxcrypt' => :logical
  depends_on 'openssl' => :executable
  depends_on 'zlib' => :executable

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
