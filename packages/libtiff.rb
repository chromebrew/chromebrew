require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.4.0'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.4.0.tar.xz'
  source_sha256 '49307b510048ccc7bc40f2cba6e8439182fe6e654057c1a1683139bf2ecb1dc1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.4.0_armv7l/libtiff-4.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.4.0_armv7l/libtiff-4.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.4.0_i686/libtiff-4.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtiff/4.4.0_x86_64/libtiff-4.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a971b42ca81eaf5375b09c69b34e14d367a8c0b86802d25dc1c8f0b89ed6ab76',
     armv7l: 'a971b42ca81eaf5375b09c69b34e14d367a8c0b86802d25dc1c8f0b89ed6ab76',
       i686: '2eaf5efe70745023e0f70670247338eebc7b75df8df85ec72980056954d7a924',
     x86_64: '33129073011fd853518e91376a84fa0ddbc61605c041297c0d130294a113f389'
  })

  depends_on 'freeglut'
  depends_on 'imake' => :build
  depends_on 'libdeflate'
  depends_on 'libglu'
  depends_on 'libice'
  depends_on 'libjpeg'
  depends_on 'libsm'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'libxi'
  depends_on 'mesa'
  depends_on 'wget' => :build
  depends_on 'zstd'

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
