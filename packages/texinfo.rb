require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.7-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-6.7.tar.xz'
  source_sha256 '988403c1542d15ad044600b909997ba3079b10e03224c61188117f3676b02caa'

  depends_on 'gettext' => :build
  depends_on 'perl'
  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'
  depends_on 'ncursesw'

  def self.build
    # configure and make
    system "./configure #{CREW_OPTIONS}
              --with-external-Text-Unidecode
              --with-external-Unicode-EastAsianWidth"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
