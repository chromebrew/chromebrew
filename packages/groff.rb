require 'buildsystems/autotools'

class Groff < Autotools
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.23.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/groff.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e64b76b272bc182c6525c7eef2c46515a34a8a5f4c5baa98232e5a89fcf01b1',
     armv7l: '7e64b76b272bc182c6525c7eef2c46515a34a8a5f4c5baa98232e5a89fcf01b1',
       i686: '6e0ff314086dfd363f162cc1f397eda4777391de0052566a1494aac62be23aa7',
     x86_64: '3f3bf23656ec19567fab24646361569c2e42f8273e473b229eb5800ea53d1d30'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'netpbm' => :build
  # depends_on 'libice' # R (Not needed for groff binary)
  # depends_on 'libsm' # R (Not needed for groff binary)
  # depends_on 'libx11' # R (Not needed for groff binary)
  # depends_on 'libxaw' # R (Not needed for groff binary)
  # depends_on 'libxmu' # R (Not needed for groff binary)
  # depends_on 'libxt' # R (Not needed for groff binary)
  depends_on 'uchardet' => :build

  configure_options '--without-x'
end
