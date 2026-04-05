require 'buildsystems/meson'

class Zenity < Meson
  description 'A tool that allows you to display GTK dialog boxes in commandline and shell scripts.'
  homepage 'https://wiki.gnome.org/Projects/Zenity'
  version '4.2.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/zenity.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad538ff18a60e55cae608b42bd3ce92b1697a003220a9baeb2534c78c6575a97',
     armv7l: 'ad538ff18a60e55cae608b42bd3ce92b1697a003220a9baeb2534c78c6575a97',
     x86_64: 'cef68f9e259ac5a704ae28496ba4c2eed4ab42e08fb695731ef01a044cea5d43'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :library
  depends_on 'libadwaita' => :library
  depends_on 'pango' => :library
  depends_on 'py3_itstool' => :build
  depends_on 'webkit2gtk' => :build

  gnome
end
