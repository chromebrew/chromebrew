require 'buildsystems/autotools'

class Gtksourceview_3 < Autotools
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '3.24.11'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/gtksourceview/3.24/gtksourceview-3.24.11.tar.xz'
  source_sha256 '691b074a37b2a307f7f48edc5b8c7afa7301709be56378ccf9cc9735909077fd'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '66c81231c2866221935586f1230a5be8df66685bbe29cc9c44063a0d5999dc5b',
     armv7l: '66c81231c2866221935586f1230a5be8df66685bbe29cc9c44063a0d5999dc5b',
     i686: '05d72c6ec22ca912ee561db41a42f3ab8ea723f1cdb607f75e8dc60466a40a19',
     x86_64: '539da69432b1494f60cdc5d498f0ec13d89835688b3775a1b0a7d72c671b8454'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
  depends_on 'fontconfig' => :build
  depends_on 'freetype' => :build
  depends_on 'fribidi' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glade' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk4' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libsoup' => :build
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'zlibpkg' # R

  gnome

  configure_options '--enable-glade-catalog --enable-gtk-doc --disable-gtk-doc-html'
end
