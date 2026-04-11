require 'buildsystems/meson'

class Gtk_doc < Meson
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.36.1'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-doc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f2cc2a0f5be9940324b02297f7b40a86dbce242d72161e4c3eced24325730e3',
     armv7l: '6f2cc2a0f5be9940324b02297f7b40a86dbce242d72161e4c3eced24325730e3',
       i686: 'd79f146d11e7760d35d2ee5bbeefe9ce1b52633a068a7bdc64e6022e484e63f0',
     x86_64: '1ade82592f9d6ca1e910f5631b15f904614422f8ec8f26b83ec787aa2d2b6264'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glib' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_parameterized' => :build

  gnome
end
