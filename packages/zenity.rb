require 'buildsystems/meson'

class Zenity < Meson
  description 'A tool that allows you to display GTK dialog boxes in commandline and shell scripts.'
  homepage 'https://wiki.gnome.org/Projects/Zenity'
  version '4.0.1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/zenity.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '223b0b0ebfe52714948e28749002250c84bf73ec1db0906e4572583d2f9e0287',
     armv7l: '223b0b0ebfe52714948e28749002250c84bf73ec1db0906e4572583d2f9e0287',
     x86_64: 'c461828c5bfa673184b08ace17c1a0fc525ee85bcabe772c5e8c880213778f30'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' => :build
  depends_on 'gtk4' # R
  depends_on 'libadwaita' # R
  depends_on 'pango' # R
  depends_on 'webkit2gtk' => :build

  gnome
end
