require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.1.5'
  source_url 'https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.4.5.tar.bz2'
  source_sha256 'd0e05438165884f21658154c709075feaf98c93ee5c694b951533ac425a9a711'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
