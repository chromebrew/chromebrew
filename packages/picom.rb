require 'buildsystems/meson'

class Picom < Meson
  description 'Lightweight compositor for X11 (previously a compton fork)'
  homepage 'https://github.com/yshui/picom/'
  version '13'
  license 'MPL-2.0 and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/yshui/picom.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c756a9f79b3944e015aabf6e1d4e3256d2df89cb4d65cafa2d67854b5467e0d9',
     armv7l: 'c756a9f79b3944e015aabf6e1d4e3256d2df89cb4d65cafa2d67854b5467e0d9',
     x86_64: 'e5fd631205f6b6dd24f9ccce6b5cb9afe43ed06a046e44a33573f46b3d09d239'
  })

  depends_on 'dbus' => :executable
  depends_on 'desktop_file_utilities' => :executable
  depends_on 'gegl' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libconfig' => :executable
  depends_on 'libepoxy' => :executable
  depends_on 'libev' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'mesa' => :executable
  depends_on 'pcre' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'pixman' => :executable
  # depends_on 'uthash' => :executable
  depends_on 'xcb_util' => :executable
  depends_on 'xcb_util_image' => :executable
  depends_on 'xcb_util_renderutil' => :executable
  depends_on 'xdg_base' => :executable
  depends_on 'xprop' => :executable # Needed for picom-trans.
  depends_on 'xwininfo' => :executable # Needed for picom-trans.

  def self.postinstall
    ExitMessage.add <<~EOM

      Note that picom requires a Window Manager to be running.  Sommelier does not count.
      Some examples are the following: Berry, Openbox, i3, sowm, bspwm, and dwm.
    EOM
  end
end
