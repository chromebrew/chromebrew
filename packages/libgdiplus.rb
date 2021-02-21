require 'package'

class Libgdiplus < Package
  description 'libgdiplus is the mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.0.5-1'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/libgdiplus/libgdiplus-6.0.5.tar.gz'
  source_sha256 'b81e4e5cc3e4831b2945de08bef26eb1bdcd795aeaf8f971b221c51213a025ef'

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
