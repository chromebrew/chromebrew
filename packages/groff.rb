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
    aarch64: 'c3b103307d0dbac5754652a1e17a6baacb3b22bd07856c60a6339b973dd073c5',
     armv7l: 'c3b103307d0dbac5754652a1e17a6baacb3b22bd07856c60a6339b973dd073c5',
       i686: '8de28bbe694839b9b657f321a54656d0e5a09669846c37b78b32ce876f120a8c',
     x86_64: '188ba47477f4e3d468f4ccd91b0915f676d9dddb524991f7f70d81cc824e8213'
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
  depends_on 'uchardet' # R

  configure_options '--without-x'
end
