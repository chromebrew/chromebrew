require 'package'

class Moreutils < Package
  description 'moreutils is a growing collection of the unix tools that nobody thought to write long ago when unix was young.'
  homepage 'https://joeyh.name/code/moreutils/'
  version '0.60'
  compatibility 'all'
  source_url 'http://http.debian.net/debian/pool/main/m/moreutils/moreutils_0.60.orig.tar.xz'
  source_sha256 'e42d18bacbd2d003779a55fb3542befa5d1d217ee37c1874e8c497581ebc17c5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.60-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.60-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.60-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.60-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0c7f2b822e06c806969e5666069933e9d97932320d9759713217e700ad3b1d4d',
     armv7l: '0c7f2b822e06c806969e5666069933e9d97932320d9759713217e700ad3b1d4d',
       i686: '63f39101b144273c158aa38e88aa3af2ca84925c52793fdd9beed85da865aa6b',
     x86_64: 'dea55d855398f5b88d255ab185f44446acb57ae0d1108057755278f68dc1f4f8',
  })

  depends_on 'docbook'
  depends_on 'libxslt'

  def self.build
    system "sed -i 's,PREFIX?=/usr,PREFIX?=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,DOCBOOKXSL?=/usr/share/xml/docbook/stylesheet/docbook-xsl,DOCBOOKXSL?=#{CREW_PREFIX}/docbook,' Makefile"
    system "sed -i 's,share/man,man,g' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
