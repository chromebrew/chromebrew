require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.7p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_7_P1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0ccf5ab7a571146f21b2fd13790cd50a902ab817164ecde463ae31122572428',
     armv7l: 'c0ccf5ab7a571146f21b2fd13790cd50a902ab817164ecde463ae31122572428',
       i686: 'e75f646c1a4ec7725c2d7b183c2c92c239b97ddc40b05d70aec2208b6e8ffd27',
     x86_64: '016730bd89cc50b01383d126d8c0c120e19c1e8ebd10d7122aed9138c55746c1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
