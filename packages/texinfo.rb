require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.5'
  source_url 'http://ftpmirror.gnu.org/texinfo/texinfo-6.5.tar.xz'
  source_sha256 '77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5efcbcab8d9961230704abb8dbc2f4a3b18c27898231e70d0bbefb5818c908e2',
     armv7l: '5efcbcab8d9961230704abb8dbc2f4a3b18c27898231e70d0bbefb5818c908e2',
       i686: '07157f88ec58254a8e5c2965a1b1c8eac1159358c22b64dc191f150567d024a2',
     x86_64: '5725777dd74498d46aab775b7152ba42b33d8551e73c77ced2b8807e8e9ccf38',
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
