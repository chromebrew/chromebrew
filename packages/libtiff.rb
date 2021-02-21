require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.2.0'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.2.0.tar.gz'
  source_sha256 'eb0484e568ead8fa23b513e9b0041df7e327f4ee2d22db5a533929dfc19633cb'

  depends_on 'libx11'
  depends_on 'libjpeg'
  depends_on 'libwebp'
  depends_on 'libdeflate'
  depends_on 'imake' => :build
  
  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
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
end
