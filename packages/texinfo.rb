require 'buildsystems/autotools'

class Texinfo < Autotools
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version "7.2-#{CREW_PERL_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://git.savannah.gnu.org/cgit/texinfo.git/snapshot/texinfo-#{version.split('-').first}.tar.gz"
  source_sha256 'dc6c36214d03cedba0cafe483ade60be2a3d78fc6074125215c805bc5fddf305'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '749fd3caf7acfa85c0f567ddb521691e114a3f077848778df14f1e3cc07306a1',
     armv7l: '749fd3caf7acfa85c0f567ddb521691e114a3f077848778df14f1e3cc07306a1',
       i686: '62585c50b3dfefe2a1e2d7ef4aa801c2471ad8b119041035e70e40560c25c561',
     x86_64: 'e1f4f26cc112d9368f3f050a504a073c1f730b123600c3517e162dff1e89f070'
  })

  depends_on 'glibc' # R
  depends_on 'libunistring' # R
  depends_on 'ncurses' # R
  depends_on 'perl' # L
  depends_on 'perl_locale_messages' # L
  depends_on 'perl_text_unidecode' # L
  depends_on 'perl_unicode_eastasianwidth' # L

  autotools_configure_options '--with-external-Text-Unidecode \
    --with-external-Unicode-EastAsianWidth'

  run_tests
end
