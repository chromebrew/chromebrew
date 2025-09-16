require 'buildsystems/meson'

class Gnome_terminal < Meson
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  version '3.97.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b00ee6a520a0b3123120f91ce84f87b61cd50f878141fbd7ce39929f58974e82',
     armv7l: 'b00ee6a520a0b3123120f91ce84f87b61cd50f878141fbd7ce39929f58974e82',
     x86_64: '272474ab973994b18cf260e77c3eed53456d99374f0f33081f7e3a52f8d6b30d'
  })

  depends_on 'adobe_source_code_pro_fonts' # L (Needed for monospace fonts)
  depends_on 'dbus' # L
  depends_on 'dconf' => :build
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libadwaita' # R
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
