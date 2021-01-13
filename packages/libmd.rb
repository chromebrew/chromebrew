require 'package'

class Libmd < Package
  description 'This library provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://archive.hadrons.org/software/libmd/libmd-1.0.3.tar.xz'
  source_sha256 '5a02097f95cc250a3f1001865e4dbba5f1d15554120f95693c0541923c52af4a'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
