require 'package'

class Imlib2 < Package
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.9.1'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://downloads.sourceforge.net/enlightenment/imlib2-#{version}.tar.xz"
  source_sha256 '4a224038bfffbe5d4d250c44e05f4ee5ae24dcfef8395b1677c715c58f764d43'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3975a861cde1bc361f8045e80b580e92585308856cdf64fb419b97be43e50e4c',
     armv7l: '3975a861cde1bc361f8045e80b580e92585308856cdf64fb419b97be43e50e4c',
     x86_64: '5a301b10f322d868e0d1a2e13b9190c95064e4f50bc7654b12e7650f9f2812ef'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'giflib'
  depends_on 'libid3tag'
  depends_on 'libheif'
  depends_on 'libjpeg_turbo'
  depends_on 'libjxl'
  depends_on 'libtiff'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxext'
  depends_on 'protobuf_c'
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libbsd' # R
  depends_on 'libdeflate' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libwebp' # R
  depends_on 'libxau' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxml2' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system "./configure \
      #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc/imlib2 \
      --x-libraries=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
