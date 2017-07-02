require 'package'

class Libopus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'http://opus-codec.org/'
  version '1.1.5'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.1.5.tar.gz'
  source_sha256 'eb84981ca0f40a3e5d5e58d2e8582cb2fee05a022825a6dfe14d14b04eb563e4'

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
