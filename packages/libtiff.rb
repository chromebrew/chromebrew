require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.5.0-2'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.5.0.tar.xz'
  source_sha256 'dafac979c5e7b6c650025569c5a4e720995ba5f17bc17e6276d1f12427be267c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-2_armv7l/libtiff-4.5.0-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-2_armv7l/libtiff-4.5.0-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-2_i686/libtiff-4.5.0-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.5.0-2_x86_64/libtiff-4.5.0-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ce768aeed2182905c375946e27c6b227765f08021626e3a5cae33886efb5ad6d',
     armv7l: 'ce768aeed2182905c375946e27c6b227765f08021626e3a5cae33886efb5ad6d',
       i686: 'a796a1702890d7157f5b1482d00350c446094fdf4859719c4bbbce6a3675aa39',
     x86_64: '84f73d6bdab2a7abeddde8e8e89e157c57127fc668d06190658fc0fa4fa45c7c'
  })

  depends_on 'freeglut' unless ARCH == 'i686' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'imake' => :build
  depends_on 'jbigkit' # R
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

  no_env_options

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    @x = ARCH == 'i686' ? '' : '--with-x --enable-webp'
    system "#{CREW_ENV_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} ./configure #{CREW_OPTIONS} \
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
    # Remove static library.
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libtiff.a"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
