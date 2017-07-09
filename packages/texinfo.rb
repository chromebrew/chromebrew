require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.4'
  source_url 'http://ftpmirror.gnu.org/texinfo/texinfo-6.4.tar.xz'
  source_sha256 '6ae2e61d87c6310f9af7c6f2426bd0470f251d1a6deb61fba83a3b3baff32c3a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/texinfo-6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/texinfo-6.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/texinfo-6.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/texinfo-6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0ebcf7a425ce2b0aa96d96c8310e43804915a7005ed9308c7788ad6367d33e4b',
     armv7l: '0ebcf7a425ce2b0aa96d96c8310e43804915a7005ed9308c7788ad6367d33e4b',
       i686: '4916592a77d9a56506d9c410d7bda912c089cb3f74a5f7a90ca15f6b90a60365',
     x86_64: '0cbfd358c4c970920793a1fbd422cc7e06f03e2ba4caf7e69d2342554bb12ba7',
  })

  depends_on 'gettext' => :build
  depends_on 'perl'
  depends_on 'ncurses'

  def self.build
    # installing necessary perl modules
    system 'cpan', 'install', 'CPAN', 'Locale::Messages', 'Text::Unidecode', 'Unicode::EastAsianWidth'

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
