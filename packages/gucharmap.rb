require 'buildsystems/meson'

class Gucharmap < Meson
  description 'GNOME Character Map, based on the Unicode Character Database.'
  homepage 'https://wiki.gnome.org/Apps/Gucharmap'
  version '18.0.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gucharmap.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ca881b5a1481fb97890051bc20bd8153a5522af63d94d3aea8a41a623dd867e',
     armv7l: '2ca881b5a1481fb97890051bc20bd8153a5522af63d94d3aea8a41a623dd867e',
     x86_64: 'b6253c8e631771609cdb6225a662f69b47ee7b26c9621b2479ab5ec36601a8c4'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utilities' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
