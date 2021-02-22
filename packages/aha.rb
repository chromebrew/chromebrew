require 'package'

class Aha < Package
  description 'ANSI HTML Adapter'
  homepage 'https://github.com/theZiz/aha'
  version '0.5.1'
  compatibility 'all'
  source_url 'https://github.com/theZiz/aha/archive/0.5.1.tar.gz'
  source_sha256 '6aea13487f6b5c3e453a447a67345f8095282f5acd97344466816b05ebd0b3b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aha-0.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aha-0.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aha-0.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aha-0.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ccb183b558d74f534a4b5afdf1f28e74507349443fbf1238d053a24140fff02c',
     armv7l: 'ccb183b558d74f534a4b5afdf1f28e74507349443fbf1238d053a24140fff02c',
       i686: '010ea772bd1963315e7b18908148482bec0d8fc0bc2cc640f192243044251f75',
     x86_64: 'b410c3c570c934576e161e077b5092cf231ce7d9a67e3b697435a64cc40158aa',
  })

  def self.patch
    system "sed -i 's:-Wextra:-Wextra -pipe -flto -O2:g' Makefile"
    system "sed -i 's:PREFIX?=/usr/local:PREFIX?=#{CREW_PREFIX}:g' Makefile"
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
