require 'buildsystems/autotools'

class Ddrescue < Autotools
  description 'GNU ddrescue is a data recovery tool.'
  homepage 'https://www.gnu.org/software/ddrescue/'
  version '1.30'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/ddrescue/ddrescue-#{version}.tar.lz"
  source_sha256 '2264622d309d6c87a1cfc19148292b8859a688e9bc02d4702f5cd4f288745542'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abc719d94dc994ffc18cbe065e6606282d04f78652cab536897af2773b447d0d',
     armv7l: 'abc719d94dc994ffc18cbe065e6606282d04f78652cab536897af2773b447d0d',
       i686: 'b53bcbb1219c17db6cc3979e792a847904b0782ac2f045ad26bacfdbc52ed44e',
     x86_64: '8fca45af7835153cff43b00cebc1a990b450070f7e7de16887d9ff4b91bcdf0e'
  })

  autotools_configure_options '--enable-non-posix'
end
