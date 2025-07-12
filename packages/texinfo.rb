require 'buildsystems/autotools'

class Texinfo < Autotools
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version "7.2-#{CREW_PERL_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://git.savannah.gnu.org/cgit/texinfo.git/snapshot/texinfo-#{version.split('-').first}.tar.gz"
  source_sha256 'c4bc246447a9f81c5f578829713a48387b007ab01dbe2705fe24d105e2303693'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eeddad66dce11b52a37c3bde8f2b5ac74f406eba1f44f911b9ad9c8f4973fbcc',
     armv7l: 'eeddad66dce11b52a37c3bde8f2b5ac74f406eba1f44f911b9ad9c8f4973fbcc',
       i686: '20a9e39352127c908f03cc40c4eced6ce29b8e77e1bd8ac4ec74f26e0a667f47',
     x86_64: '6304cda178394a4466c657be65ca517292606f482796510d51003fec6f212347'
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

  # run_tests
end
