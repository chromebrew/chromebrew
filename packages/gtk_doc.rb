require 'buildsystems/meson'

class Gtk_doc < Meson
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.37.0'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-doc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cecbc435d538e86962eca10db8f9b6917a87c975986c04c10832d621a71be786',
     armv7l: 'cecbc435d538e86962eca10db8f9b6917a87c975986c04c10832d621a71be786',
       i686: '5b15384d0ad97a647eaf34b4278d9ca0852f4589dd62d275383b82d69945e476',
     x86_64: '1cf0160819cd8b01a6459ce495c11d909d74526cae09d5229ba26e6b449cf637'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glib' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'py3_parameterized' => :build
  depends_on 'py3_pygments' => :build

  gnome
end
