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
    aarch64: '9a4f8c30008de43e79abb471c0d97c13dfa30ca0a9cc8a53a33729a5dd5f4b3b',
     armv7l: '9a4f8c30008de43e79abb471c0d97c13dfa30ca0a9cc8a53a33729a5dd5f4b3b',
       i686: '58e57d31366d315f474d32e4949a53b289a565a000406ecbd575cac513d60089',
     x86_64: '40a49b1f6ef81f491f4c36accf88c701abc0cbe7f4e54d7d3ac1ae6a8250b494'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R

  autotools_configure_options '--with-gui=none'
end
