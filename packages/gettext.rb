require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.21'
  compatibility 'all'
  source_url 'https://gnu.freemirror.org/gnu/gettext/gettext-0.21.tar.lz'
  source_sha256 '435b546e3880ab767c967c0731b20629a0cb0ba620e6bac2f590f401c10ebb45'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6489c458f5f3ad46d60415fd5097bac4ed5d1c739500b2ca90262a75cb05b17e',
     armv7l: '6489c458f5f3ad46d60415fd5097bac4ed5d1c739500b2ca90262a75cb05b17e',
       i686: '178c97cca996dbb982deb8ab6ce7faea9c1ae4795e8f716a1a92565b5c7b52c6',
     x86_64: 'c51bf8877623c0c797b6a3eaf36a60693a45a044371601d065f8e904f8eadd8c',
  })

  depends_on 'ncurses'
  depends_on 'libxml2'
  depends_on 'icu4c'
  depends_on 'jdk8' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-static --enable-shared --with-pic"
    system 'make'
  end

  def self.check
    #system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
