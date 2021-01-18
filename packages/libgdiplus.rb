require 'package'

class Libgdiplus < Package
  description 'libgdiplus is the mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.0.5'
  compatibility 'all'
  source_url 'https://github.com/mono/libgdiplus/archive/6.0.5.tar.gz'
  source_sha256 '1fd034f4b636214cc24e94c563cd10b3f3444d9f0660927b60e63fd4131d97fa'

  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'graphite'
  depends_on 'libexif'
  depends_on 'libtiff'
  
  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
            --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
