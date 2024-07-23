require 'buildsystems/autotools'

class Texinfo < Autotools
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '7.1.0.90-perl5.40'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/cgit/texinfo.git/snapshot/texinfo-c5961c61fa9c9f817f3569585fb75a3512c872de.tar.gz'
  source_sha256 'd5058642862d0efa2ed98218fdd8830d4e018658aaa8df010d3d30a996812286'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f544f32ab5100a1ddd07d5b22af52246afad99a47fe1af3358e33ddce9fbb13',
     armv7l: '5f544f32ab5100a1ddd07d5b22af52246afad99a47fe1af3358e33ddce9fbb13',
       i686: '3b88d3d6409604c7fbe06013c895e1c02758b6bf8d40025e77ccd749f63ff079',
     x86_64: '89242d4e2e146c41de85e8e3641fa53422cc3ef29f8464b7357c7e3df0ab8ad2'
  })

  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libunistring' # R
  depends_on 'ncurses' # R
  depends_on 'perl' # L
  depends_on 'perl_locale_messages' # L
  depends_on 'perl_text_unidecode' # L
  depends_on 'perl_unicode_eastasianwidth' # L

  configure_options '--with-external-Text-Unidecode \
    --with-external-Unicode-EastAsianWidth'

  run_tests
end
