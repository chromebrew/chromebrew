require 'package'

class Libvips < Package
  description 'A fast image processing library with low memory needs'
  homepage 'https://www.libvips.org/'
  version '8.10.6-beta2'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/libvips/libvips/archive/v#{version}.tar.gz"
  source_sha256 'b2412f580ba83129d55e57a73c7c4fdb53e60a39c48910acc5f0d80518deb7a5'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '2d95674bfc951f232315ea0e93311d5982b9975c76f7f8d092f8d3fcfe6810b6',
     armv7l: '2d95674bfc951f232315ea0e93311d5982b9975c76f7f8d092f8d3fcfe6810b6',
     x86_64: '3d2244043e9fd70c3a7429e98c825243cadac0e613a3c5443ee3a243721d8815'
  })

  depends_on 'cfitsio'
  depends_on 'fftw'
  depends_on 'imagemagick7'
  depends_on 'lcms'
  depends_on 'libexif'
  depends_on 'libgsf'
  depends_on 'libheif'
  depends_on 'libimagequant'
  depends_on 'librsvg'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'gstreamer'
  depends_on 'poppler'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
