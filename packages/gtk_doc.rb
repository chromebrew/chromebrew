require 'buildsystems/meson'

class Gtk_doc < Meson
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.36.0'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-doc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d95e801773918ffb4f05e9b2bba4401bfb646e1814a17e8aa79dcbb08bec1c2',
     armv7l: '2d95e801773918ffb4f05e9b2bba4401bfb646e1814a17e8aa79dcbb08bec1c2',
       i686: '1c25ee5d69a256579de007e370a0cf87acda9450cd0bde18ab991a92537a6683',
     x86_64: '926854ae418f16933e3ecadbec46584c10b3e5b5ab90e91a436c1e172c9de3eb'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glib' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_parameterized' => :build

  gnome
end
