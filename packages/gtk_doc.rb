require 'buildsystems/meson'

class Gtk_doc < Meson
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.34.0'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-doc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '6993961e70ba19d27ada2b88912664bc1a3b7df324871b7227bb20bbf78b9a57',
    aarch64: '4af9d804ce5cde36cd7a404aade21ff31db2840d7e951352ac4baec4c8b0154a',
     armv7l: '4af9d804ce5cde36cd7a404aade21ff31db2840d7e951352ac4baec4c8b0154a',
     x86_64: 'd6c51f109c288c37bade4c353049e1e58cb2e6ff37edde5c212093e401419fd1'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glib' => :build
  depends_on 'itstool' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build

  gnome
end
