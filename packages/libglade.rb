require 'buildsystems/autotools'

class Libglade < Autotools
  description 'Libglade is a library that performs a similar job to the C source output routines in the GLADE user interface builder.'
  homepage 'http://www.jamesh.id.au/software/libglade/'
  version '2.6.4-1'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libglade/2.6/libglade-2.6.4.tar.bz2'
  source_sha256 '64361e7647839d36ed8336d992fd210d3e8139882269bed47dc4674980165dec'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b4cad18d6fb3ed0a1594c387ceb3f2d635b82f4ec157d2e07c0d8a8a7cacd15f',
     armv7l: 'b4cad18d6fb3ed0a1594c387ceb3f2d635b82f4ec157d2e07c0d8a8a7cacd15f',
     x86_64: 'a950a82a9b670902efd4418b9947ef47764520811fd65d2623ddc8416d818f05'
  })

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'pango'

  gnome
  no_lto
end
