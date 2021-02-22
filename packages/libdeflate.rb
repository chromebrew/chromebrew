require 'package'

class Libdeflate < Package
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.7'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate/archive/v1.7.tar.gz'
  source_sha256 'a5e6a0a9ab69f40f0f59332106532ca76918977a974e7004977a9498e3f11350'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87ef4380e735e1e8654e7229f0c5422972cb20e54bb59fcac27131f0a6400973',
     armv7l: '87ef4380e735e1e8654e7229f0c5422972cb20e54bb59fcac27131f0a6400973',
       i686: 'ce7408d49285c857369a7475579f3ddc6df4b0b4adf97f7aca75aff0934c6477',
     x86_64: 'd912fedc4f0fe8160aee0346be159b58ffd62c1ba6ae0ee6bff3611b36cfd1b0',
  })
  
  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
  end
end
