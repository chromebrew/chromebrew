require 'package'

class Mjpegtools < Package
  description 'Video capture, editing, playback, and compression to MPEG of MJPEG video'
  homepage 'https://mjpeg.sourceforge.io/'
  @_ver = '2.2.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/mjpeg/files/mjpegtools/2.2.0/mjpegtools-2.2.0.tar.bz2'
  source_sha256 'a84349839471052db1ef691134aacf905b314dfce8762d47e10edcc9ab5f97d8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mjpegtools-2.2.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '50bef51c33555ed239c35fe88ce52e025cbefc7bc3ce80158b186bb4d348f746',
     armv7l: '50bef51c33555ed239c35fe88ce52e025cbefc7bc3ce80158b186bb4d348f746',
       i686: '62337fe4925af757764dac019076a22120377c808d9081fd3d1713192c092da3',
     x86_64: 'f046724650de108d5ed9f7f000953de6bd13425d5e1b5be6785817672c190f3f'
  })

  depends_on 'libdv'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libsdl'
  depends_on 'libsdl2'
  depends_on 'libx11'
  depends_on 'v4l_utils' => :build

  def self.build
    system 'ls -aFl'
    system '[ -x configure ] || ./autogen.sh'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
