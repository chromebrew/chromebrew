require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '7.0.3-perl5.38'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-7.0.3.tar.xz'
  source_sha256 '74b420d09d7f528e84f97aa330f0dd69a98a6053e7a4e01767eed115038807bf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.38_armv7l/texinfo-7.0.3-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.38_armv7l/texinfo-7.0.3-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.38_i686/texinfo-7.0.3-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.38_x86_64/texinfo-7.0.3-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1a335d6c6c27b1427c8b373f72f577bac1c26087575e3c82040f331249648672',
     armv7l: '1a335d6c6c27b1427c8b373f72f577bac1c26087575e3c82040f331249648672',
       i686: '89d51b99fb05f96fc867ba354d4b872c49b5d17b321eb4c49b474a86439c421f',
     x86_64: 'aea090d1b6511ec19e85b9e258c3d63eb361a43755f9b9886a4bf95f8fe4e062'
  })

  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'perl' # L
  depends_on 'perl_locale_messages' # L
  depends_on 'perl_text_unidecode' # L
  depends_on 'perl_unicode_eastasianwidth' # L

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS} \
      --with-external-Text-Unidecode \
      --with-external-Unicode-EastAsianWidth"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
