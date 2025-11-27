require 'buildsystems/autotools'

class Trousers < Autotools
  description 'The open-source TCG Software Stack.'
  homepage 'https://trousers.sourceforge.net/'
  version '0.3.15'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://git.code.sf.net/p/trousers/trousers.git'
  git_hashtag "TROUSERS_#{version.tr('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R

  autotools_configure_options '--with-gui=none'
end
