require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.1.5'
  source_url 'https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.4.5.tar.bz2'
  source_sha1 'e979eb20b789c1fc47107ef93a584924e34dd195'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
