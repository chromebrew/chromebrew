require 'package'

class Ticker < Package
  description 'Ticker is a simple little program that scrolls a message across the top or bottom line of your screen like a stock ticker.'
  homepage 'https://joeyh.name/code/ticker/'
  version '1.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/t/ticker/ticker_1.13.tar.xz'
  source_sha256 '5d80787d4c27b3dc4f8ebec2868d52bcf365c1ef928e63dc6c3ac541efe40e98'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ticker/1.13_armv7l/ticker-1.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ticker/1.13_armv7l/ticker-1.13-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ticker/1.13_i686/ticker-1.13-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ticker/1.13_x86_64/ticker-1.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd91f2b9b28e55878423c3f67b172d2983a346bae1e7d4d639343d0c86e1758c9',
     armv7l: 'd91f2b9b28e55878423c3f67b172d2983a346bae1e7d4d639343d0c86e1758c9',
       i686: '1319a716958c27c529e1427dd5789ca99a8d1e95200ca22451d3694b7e01cc93',
     x86_64: '42f30e5bab0f5f2d54046bf044cd27f09e72d5b91ba89a788cb5189edff63a75'
  })

  depends_on 'slang'

  def self.patch
    system "sed -i '12d' ticker.c"
    system "sed -i 's:#!/usr/bin/perl -w:#!#{CREW_PREFIX}/bin/perl -w:' sysinfo-ticker"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} || true" # Configure will fail
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
