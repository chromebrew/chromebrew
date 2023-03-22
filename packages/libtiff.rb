require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.5.0-1'
  compatibility 'all'
  license 'libtiff'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.5.0.tar.xz'
  source_sha256 'dafac979c5e7b6c650025569c5a4e720995ba5f17bc17e6276d1f12427be267c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-1_armv7l/libtiff-4.5.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-1_armv7l/libtiff-4.5.0-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-1_x86_64/libtiff-4.5.0-1-chromeos-x86_64.tar.zst',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-1_i686/libtiff-4.5.0-1-chromeos-i686.tar.zst'
  })
  binary_sha256({
    aarch64: '7f675f104ab5e96bd2d36e0b20c66cd04e28670f656754d63efec6fb0b75a8c7',
     armv7l: '7f675f104ab5e96bd2d36e0b20c66cd04e28670f656754d63efec6fb0b75a8c7',
     x86_64: '6bc2360a7b3d5d986575dd8f2220efbeea3bb227dfcc707a9e8cc6168e632d7f',
    i686: 'e30b4ddd50c20b8710b7cbc0277ce7e41e28ec5fc7fe74b3509f4fea552c050e'
  })

  depends_on 'freeglut' unless ARCH == 'i686' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'imake' => :build
  depends_on 'libdeflate' # R
  depends_on 'libglu' unless ARCH == 'i686' # R
  depends_on 'libglvnd' unless ARCH == 'i686' # R
  depends_on 'libice' unless ARCH == 'i686' # R
  depends_on 'libjpeg' # R
  depends_on 'libsm' unless ARCH == 'i686' # R
  depends_on 'libwebp' unless ARCH == 'i686' # R
  depends_on 'libx11' unless ARCH == 'i686' # R
  depends_on 'libxi' unless ARCH == 'i686' # R
  depends_on 'mesa' => :build unless ARCH == 'i686'
  depends_on 'wget' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    @x = ARCH == 'i686' ? '' : '--with-x --enable-webp'
    system "./configure #{CREW_OPTIONS} \
      #{@x} \
      --enable-zlib \
      --enable-mdi \
      --enable-libdeflate \
      --enable-pixarlog \
      --enable-jpeg \
      --enable-lzma \
      --enable-zstd \
      --enable-cxx"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
