require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.7'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-6.7.tar.xz'
  source_sha256 '988403c1542d15ad044600b909997ba3079b10e03224c61188117f3676b02caa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c01bcef457daa115be3bb4a7dbbf36263b491f500217e226b5ffbcb8777d706d',
     armv7l: 'c01bcef457daa115be3bb4a7dbbf36263b491f500217e226b5ffbcb8777d706d',
       i686: '14d8e01b60692cba6eae6de7c7fd6bb2cf9187b22bc51f3d45d5c6340cb47619',
     x86_64: '1f77c47871a7096cb013e696ebb0a7ce5cb9f6b5d68dd48862b5e6b605ecf4bb',
  })

  depends_on 'gettext' => :build
  depends_on 'perl'
  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'
  depends_on 'ncurses'

  def self.build
    # configure and make
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-external-Text-Unidecode',
           '--with-external-Unicode-EastAsianWidth'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
