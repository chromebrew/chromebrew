require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.4-1'
  source_url 'http://ftpmirror.gnu.org/texinfo/texinfo-6.4.tar.xz'
  source_sha256 '6ae2e61d87c6310f9af7c6f2426bd0470f251d1a6deb61fba83a3b3baff32c3a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/texinfo-6.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/texinfo-6.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/texinfo-6.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/texinfo-6.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c754230640c776b6f44910a7e5101d0d14f6aeb3a0b8c7fc0e808440c1576619',
     armv7l: 'c754230640c776b6f44910a7e5101d0d14f6aeb3a0b8c7fc0e808440c1576619',
       i686: '1b89c8829a0d945e9842efd538008f4bcf6a04ba521a37177ad12dbe2248e2c2',
     x86_64: 'b882e0b46a42e0db6afc4ab821564f454273d203ad50dbe135ef0c335b0b9c14',
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
