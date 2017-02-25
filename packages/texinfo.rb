require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.4'
  source_url 'http://ftpmirror.gnu.org/texinfo/texinfo-6.4.tar.xz'
  source_sha256 '6ae2e61d87c6310f9af7c6f2426bd0470f251d1a6deb61fba83a3b3baff32c3a'

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
