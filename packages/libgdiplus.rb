require 'package'

class Libgdiplus < Package
  description 'libgdiplus is the mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.0.5-1'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/libgdiplus/libgdiplus-6.0.5.tar.gz'
  source_sha256 'b81e4e5cc3e4831b2945de08bef26eb1bdcd795aeaf8f971b221c51213a025ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c64e89cc05e8499da3aa10b6f63fa2ada890ac1ec93135802e48a26e338998d3',
     armv7l: 'c64e89cc05e8499da3aa10b6f63fa2ada890ac1ec93135802e48a26e338998d3',
       i686: 'd74692453aeffe340db28fd820cfdbc4e372d2869d121a841ea0defc81523211',
     x86_64: '8a5e8b654ad4266d31ce25ba4f5eac6b54286a65f698c34f4e7a80df360edfed',
  })

  depends_on 'pcre'
  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'graphite'
  depends_on 'libexif'
  depends_on 'libtiff'
  depends_on 'libpng'
  depends_on 'libwebp'
  depends_on 'imake' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-libexif \
            --with-libtiff \
            --with-x11"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
