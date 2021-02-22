require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.2.0'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.2.0.tar.gz'
  source_sha256 'eb0484e568ead8fa23b513e9b0041df7e327f4ee2d22db5a533929dfc19633cb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b348ee73ff84faf3b7a6fa30f1fa36f735090aed8a96221730c001368969fba',
     armv7l: '5b348ee73ff84faf3b7a6fa30f1fa36f735090aed8a96221730c001368969fba',
       i686: '13480016d525f79282ef1b7305e851b5d843592e5aa95292a1125a5aae2fac0e',
     x86_64: 'ac6dd7686f42a8a263b9eae152626f95dfcc5b788d9e61a93685820af3fa92af',
  })

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
