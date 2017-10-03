require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.5'
  source_url 'http://ftpmirror.gnu.org/texinfo/texinfo-6.5.tar.xz'
  source_sha256 '77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62'

  binary_url ({
  })
  binary_sha256 ({
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
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end
