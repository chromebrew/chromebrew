require 'package'

class Mjpegtools < Package
  description 'Video capture, editing, playback, and compression to MPEG of MJPEG video'
  homepage 'https://mjpeg.sourceforge.io/'
  @_ver = '2.2.0_beta'
  version @_ver
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/sourceforge/mjpeg/mjpegtools-#{@_ver}.tar.gz"
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0_beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0_beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0_beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0_beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd97cffd7dd29d8d71ed830a6f4d61ce858f0c7b0b17574a0019442b02f5eb546',
     armv7l: 'd97cffd7dd29d8d71ed830a6f4d61ce858f0c7b0b17574a0019442b02f5eb546',
       i686: '7d9b5522639efcc53d86577c1fb9c0e06ec93054ed207be571abaad1f0ed01db',
     x86_64: 'efefd2df7479bb6e96832e934a66071120c0320e18a78b192f8bcd3303ec0867'
  })

  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libdv'
  depends_on 'libsdl2'
  depends_on 'v4l_utils' => ':build'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
