require 'buildsystems/autotools'

class Bc < Autotools
  description 'bc is an arbitrary precision numeric processing language.'
  homepage 'http://www.gnu.org/software/bc/'
  version '1.08.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/bc/bc-#{version}.tar.gz"
  source_sha256 '62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79c3e614e6e4860e42bfed550cacb544507afe84bc7b227fe5b09f33e7d6e7e9',
     armv7l: '79c3e614e6e4860e42bfed550cacb544507afe84bc7b227fe5b09f33e7d6e7e9',
       i686: '82c96318ca649079ca49570f1b7e9e0adc1ce0f236db1a35d95b1849966db17b',
     x86_64: 'ef7ec7a38073d1c63e54a82729dcc3fdf1f5ebb46fb6630886f2d55734ac3687'
  })

  depends_on 'readline'
  depends_on 'flex'
  depends_on 'ed' => :build
  depends_on 'texinfo' => :build
  depends_on 'ncurses' # R

  autotools_configure_options '--with-readline'

  run_tests
end
