require 'buildsystems/meson'

class Gtk_doc < Meson
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.35.0'
  license 'GPL-2 and FDL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-doc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31737a87cf902ebea9474986a016e07f52370fb77b3d96faa29d56d33b21fe13',
     armv7l: '31737a87cf902ebea9474986a016e07f52370fb77b3d96faa29d56d33b21fe13',
       i686: '6af317a1e49b98d0918b9ea0620c541968b26cf47fd6a1e50163bc34acfef800',
     x86_64: '02bae08d1334eb5233107303f1a909a85215aa30bd01675e9d51af831ea58490'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glib' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build

  gnome
end
