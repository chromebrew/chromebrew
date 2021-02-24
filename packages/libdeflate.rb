require 'package'

class Libdeflate < Package
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.7-1'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate/archive/v1.7.tar.gz'
  source_sha256 'a5e6a0a9ab69f40f0f59332106532ca76918977a974e7004977a9498e3f11350'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdeflate-1.7-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1195e3098e35caf102d85f6e094c0e4e13d0f4065bf43447168b5c3f53e59130',
     armv7l: '1195e3098e35caf102d85f6e094c0e4e13d0f4065bf43447168b5c3f53e59130',
       i686: 'bbbd9b82d8e241e6ac6db6d50ef217e4fcb8d7d029a6fe2bab514401d87f809c',
     x86_64: 'cf08842579addb9c9abe37b6bff1ff8071401c2f37c5e8278a323f40878c71e0'
  })

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      PREFIX=#{CREW_PREFIX} \
      LIBDIR=#{CREW_LIB_PREFIX} \
      make"
  end

  def self.install
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      DESTDIR=#{CREW_DEST_DIR} \
      PREFIX=#{CREW_PREFIX} \
      LIBDIR=#{CREW_LIB_PREFIX} \
      make install"
  end
end
