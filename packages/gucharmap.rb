require 'buildsystems/meson'

class Gucharmap < Meson
  description 'GNOME Character Map, based on the Unicode Character Database.'
  homepage 'https://wiki.gnome.org/Apps/Gucharmap'
  version '17.0.2'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gucharmap.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98954b209f5771cf4ac82bff6e403c780965adc4760f8641f6099e42680e09c5',
     armv7l: '98954b209f5771cf4ac82bff6e403c780965adc4760f8641f6099e42680e09c5',
     x86_64: '47b0f39348fd063f078be9a463c7a509b1965b5577c8e808b4a706a80ddcd6b7'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utilities' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection'
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'py3_itstool' => :build
  depends_on 'unicode_character_database'
  depends_on 'vala' => :build

  gnome
  no_lto # Build fails with meson.build:146:0: ERROR: Assert failed: LTO not supported

  meson_options "-Ddocs=false -Ducd_path=#{CREW_PREFIX}/share/unicode"
end
