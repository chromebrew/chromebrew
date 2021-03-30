require 'package'

class Ticker < Package
  description 'Ticker is a simple little program that scrolls a message across the top or bottom line of your screen like a stock ticker.'
  homepage 'https://joeyh.name/code/ticker/'
  version '1.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/t/ticker/ticker_1.13.tar.xz'
  source_sha256 '5d80787d4c27b3dc4f8ebec2868d52bcf365c1ef928e63dc6c3ac541efe40e98'
  
  depends_on 'slang'
  
  def self.patch
    system "sed -i '12d' ticker.c"
    system "sed -i 's:#!/usr/bin/perl -w:#!#{CREW_PREFIX}/bin/perl -w:' sysinfo-ticker"
  end
  
  def self.build
    system "./configure #{CREW_OPTIONS} || true" # Configure will fail
    system "make"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
