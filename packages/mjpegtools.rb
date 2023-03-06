require 'package'

class Mjpegtools < Package
  description 'Video capture, editing, playback, and compression to MPEG of MJPEG video'
  homepage 'https://mjpeg.sourceforge.io/'
  @_ver = '2.2.1'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/mjpeg/files/mjpegtools/2.2.1/mjpegtools-2.2.1.tar.gz'
  source_sha256 'b180536d7d9960b05e0023a197b00dcb100929a49aab71d19d55f4a1b210f49a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mjpegtools/2.2.1_armv7l/mjpegtools-2.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mjpegtools/2.2.1_armv7l/mjpegtools-2.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mjpegtools/2.2.1_i686/mjpegtools-2.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mjpegtools/2.2.1_x86_64/mjpegtools-2.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '769cff6f2acf252ff998f56f0d5e9c8fc9ed2a3e33f7639c4919675e783ee3ad',
     armv7l: '769cff6f2acf252ff998f56f0d5e9c8fc9ed2a3e33f7639c4919675e783ee3ad',
       i686: '47ec9e23a5e7cb1506ae58b52efb7d0cd3d3f11ebc3acaa2f098619bb3daaf21',
     x86_64: '967ddfd9c3024f040cdc9044e6f30d66812f5e6e5aa7c8d9982d99b88cc5f579'
  })

  depends_on 'libdv'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libsdl'
  depends_on 'libsdl2'
  depends_on 'libx11'
  depends_on 'v4l_utils' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk2' # R
  depends_on 'harfbuzz' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
