require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.2.0-1'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.2.0.tar.gz'
  source_sha256 'eb0484e568ead8fa23b513e9b0041df7e327f4ee2d22db5a533929dfc19633cb'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libtiff-4.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libtiff-4.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libtiff-4.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libtiff-4.2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a0cbdf73940274a9f34ac362e989226ad7ddbef2b6a43fdbdbd05f81eb948a3a',
     armv7l: 'a0cbdf73940274a9f34ac362e989226ad7ddbef2b6a43fdbdbd05f81eb948a3a',
       i686: '2cfebbbe502beb99cf0dd12ee49efa99cca1ef90420103f39b873828fd1b43f6',
     x86_64: '3a30356473a84f4c024c3dc399487782c6f585896a18c641b866ecad6cf528a8'
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

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
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
end
