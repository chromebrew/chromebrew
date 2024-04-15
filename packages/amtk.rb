require 'buildsystems/meson'

class Amtk < Meson
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://wiki.gnome.org/Projects/Amtk'
  version '5.6.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/amtk/5.6/amtk-5.6.1.tar.xz'
  source_sha256 'd50115b85c872aac296934b5ee726a3fa156c6f5ad96d27e0edd0aa5ad173228'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0cac9e9b31f3de8055a973430a67480efea5d04757c1b7b7ddd9887c7c4ca8db',
      armv7l: '0cac9e9b31f3de8055a973430a67480efea5d04757c1b7b7ddd9887c7c4ca8db',
      x86_64: '3f4369cafcc56717e6d5e0bb2f67e745fcc3200a7a6153045ad34ed5931e949c'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'py3_pygments' => :build

  gnome
end
