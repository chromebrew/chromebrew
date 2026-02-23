require 'buildsystems/autotools'

class Bc < Autotools
  description 'bc is an arbitrary precision numeric processing language.'
  homepage 'http://www.gnu.org/software/bc/'
  version '1.08.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/bc/bc-#{version}.tar.gz"
  source_sha256 'ae470fec429775653e042015edc928d07c8c3b2fc59765172a330d3d87785f86'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b83af08b0ea05e04155d892eeaf04579e7353c3ddf9d18d3a6ac2b75fdc936ac',
     armv7l: 'b83af08b0ea05e04155d892eeaf04579e7353c3ddf9d18d3a6ac2b75fdc936ac',
       i686: 'c1cf23f0789bf5daf82692b0db702448802826615e2f398a56c7d5c4b64820a6',
     x86_64: 'e8614051c21c99edfa950ab1ac931e1712c6efb05bc779f6d505dd03355ab367'
  })

  depends_on 'ed' => :build
  depends_on 'flex'
  depends_on 'ncurses' => :executable_only
  depends_on 'readline'
  depends_on 'readline' => :executable_only
  depends_on 'texinfo' => :build

  autotools_configure_options '--with-readline'

  run_tests
end
