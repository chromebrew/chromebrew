require 'package'

class Aha < Package
  description 'ANSI HTML Adapter'
  homepage 'https://github.com/theZiz/aha'
  version '0.5.1'
  compatibility 'all'
  source_url 'https://github.com/theZiz/aha/archive/0.5.1.tar.gz'
  source_sha256 '6aea13487f6b5c3e453a447a67345f8095282f5acd97344466816b05ebd0b3b1'

  def self.patch
    system "sed -i 's:-Wextra:-Wextra -pipe -flto -O2:g' Makefile"
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
