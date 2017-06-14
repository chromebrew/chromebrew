require 'package'

class Libopus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'http://opus-codec.org/'
  version '1.1.5'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.1.5.tar.gz'
  source_sha1 'fb6d55cf73059bd916790960c2eeffe83edabafe'

  def self.build
    system "./configure --prefix=/usr/local \
            --enable-shared \
            --enable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
