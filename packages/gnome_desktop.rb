require 'buildsystems/meson'

class Gnome_desktop < Meson
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  version '44.4'
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-desktop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6bcb8fa584a27080ea313166039709c7ed3ca1f4745ef754d779697e9323231f',
     armv7l: '6bcb8fa584a27080ea313166039709c7ed3ca1f4745ef754d779697e9323231f',
     x86_64: '1029ef4ea9678f34309eeb3d10ea85abb46a6901ef595b1f784a31bedd618acc'
  })

  depends_on 'cairo' # R
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'iso_codes' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libseccomp' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxkbfile' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'xkeyboard_config' => :build
  depends_on 'yelp_tools' => :build

  gnome

  meson_options '-Dsystemd=disabled'
end
