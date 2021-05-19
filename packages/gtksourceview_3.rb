require 'package'

class Gtksourceview_3 < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  @_ver = '3.24.11'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtksourceview/3.24/gtksourceview-3.24.11.tar.xz'
  source_sha256 '691b074a37b2a307f7f48edc5b8c7afa7301709be56378ccf9cc9735909077fd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_3/3.24.11_armv7l/gtksourceview_3-3.24.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_3/3.24.11_armv7l/gtksourceview_3-3.24.11-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_3/3.24.11_i686/gtksourceview_3-3.24.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_3/3.24.11_x86_64/gtksourceview_3-3.24.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '66c81231c2866221935586f1230a5be8df66685bbe29cc9c44063a0d5999dc5b',
     armv7l: '66c81231c2866221935586f1230a5be8df66685bbe29cc9c44063a0d5999dc5b',
       i686: '1b2163c1768580c47cc477fc336b378f2989481e117ca36b9deaf5d174195b2f',
     x86_64: '539da69432b1494f60cdc5d498f0ec13d89835688b3775a1b0a7d72c671b8454',
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'glade'
  depends_on 'graphene'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'harfbuzz'
  depends_on 'libsoup'
  depends_on 'pango'
  depends_on 'vala'
  depends_on 'vulkan_icd_loader'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-glade-catalog --enable-gtk-doc --disable-gtk-doc-html"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
