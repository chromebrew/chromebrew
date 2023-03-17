require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.5.0'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.5.0.tar.xz'
  source_sha256 'dafac979c5e7b6c650025569c5a4e720995ba5f17bc17e6276d1f12427be267c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0_armv7l/libtiff-4.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0_armv7l/libtiff-4.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0_i686/libtiff-4.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0_x86_64/libtiff-4.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7f675f104ab5e96bd2d36e0b20c66cd04e28670f656754d63efec6fb0b75a8c7',
     armv7l: '7f675f104ab5e96bd2d36e0b20c66cd04e28670f656754d63efec6fb0b75a8c7',
       i686: '5f4fb64998b71ec589113545de1b14606e8e5f4302d06a2bb5f85c06856ab8e6',
     x86_64: '6bc2360a7b3d5d986575dd8f2220efbeea3bb227dfcc707a9e8cc6168e632d7f'
  })

  depends_on 'freeglut' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'imake' => :build
  depends_on 'libdeflate' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libsm' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxi' # R
  depends_on 'mesa' => :build
  depends_on 'wget' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --with-x \
      --enable-zlib \
      --enable-mdi \
      --enable-libdeflate \
      --enable-pixarlog \
      --enable-jpeg \
      --enable-lzma \
      --enable-zstd \
      --enable-webp \
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
