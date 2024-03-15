require 'buildsystems/meson'

class Gnome_terminal < Meson
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  version '3.51.91'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '508069bccbc1e289c1c875c4366833681ff28326554675dfe5a7402a898fc0c9',
     armv7l: '508069bccbc1e289c1c875c4366833681ff28326554675dfe5a7402a898fc0c9',
     x86_64: '7845852c6237e388142b2bfd8e5f62a12f1b6852c7bc98883bb5eaf384cd954e'
  })

  depends_on 'adobe_source_code_pro_fonts' # L (Needed for monospace fonts)
  depends_on 'at_spi2_core' # R
  depends_on 'dbus' # L
  depends_on 'dconf' => :build
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libhandy' # R
  depends_on 'libx11' # R
  depends_on 'pango' # R
  depends_on 'util_linux' # R
  depends_on 'vte' # R
  depends_on 'yelp_tools' => :build

  gnome
  no_lto

  meson_options '--default-library=both \
    -Ddocs=false \
    -Dsearch_provider=false \
    -Dnautilus_extension=false'

  def self.postinstall
    ExitMessage.add 'gnome-terminal should be launched using "dbus-launch gnome-terminal"'.lightblue
  end
end
