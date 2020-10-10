require 'package'

class Xmltoman < Package
  description 'xmltoman and xmlmantohtml are two small scripts to convert xml to man pages in groff format or html.'
  homepage 'https://sourceforge.net/projects/xmltoman/'
  version '0.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/xmltoman/xmltoman/xmltoman-0.4.tar.gz/xmltoman-0.4.tar.gz'
  source_sha256 '948794a316aaecd13add60e17e476beae86644d066cb60171fc6b779f2df14b0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xmltoman-0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xmltoman-0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xmltoman-0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xmltoman-0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a0b2caaf0eee70d7a48fc6d0b3f069e867f5cd4b608231ef2578ba7db653b2bb',
     armv7l: 'a0b2caaf0eee70d7a48fc6d0b3f069e867f5cd4b608231ef2578ba7db653b2bb',
       i686: '850d213a2441ba643dc5d3dae8cb41a7204b7354e47b2332282b45f37198e0d5',
     x86_64: 'e5c6a17fd6d1a2550d15a9e93fe272e1802a503ca8e9dde849da2bffa1bd5b7d',
  })

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' xmltoman"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' xmlmantohtml"
  end

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "install -Dm644 xmltoman.1 #{CREW_DEST_MAN_PREFIX}/man1/xmltoman.1"
    system "install -Dm644 xmlmantohtml.1 #{CREW_DEST_MAN_PREFIX}/man1/xmlmantohtml.1"
  end
end
