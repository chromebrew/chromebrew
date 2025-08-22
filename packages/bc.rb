require 'buildsystems/autotools'

class Bc < Autotools
  description 'bc is an arbitrary precision numeric processing language.'
  homepage 'http://www.gnu.org/software/bc/'
  version '1.08.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/bc/bc-#{version}.tar.gz"
  source_sha256 'ae470fec429775653e042015edc928d07c8c3b2fc59765172a330d3d87785f86'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52e13f9620d74403f144e9fccf36497addd7852b56c09a85e545d2e4fa33d66e',
     armv7l: '52e13f9620d74403f144e9fccf36497addd7852b56c09a85e545d2e4fa33d66e',
       i686: 'c4ba103dfab2c2a71f3ee76520eeb5bbcdbee0a55572aa10e68280f75fe0dd38',
     x86_64: '1da8341e6a938f6c20af92afd45900b78cd17ad3dc7c2c56055421d6cc0130ab'
  })

  depends_on 'ed' => :build
  depends_on 'flex'
  depends_on 'ncurses' # R
  depends_on 'readline'
  depends_on 'texinfo' => :build

  autotools_configure_options '--with-readline'

  run_tests
end
