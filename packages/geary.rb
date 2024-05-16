require 'buildsystems/meson'

class Geary < Meson
  description 'Geary is an email application built around conversations for the GNOME desktop.'
  homepage 'https://wiki.gnome.org/Apps/Geary'
  version '46.0'
  license 'GPL2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/geary.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffdaa44a96e66a05a0ee8e4a349efc80fa3c0b3ee9eb309f8b96568da1ee8559',
     armv7l: 'ffdaa44a96e66a05a0ee8e4a349efc80fa3c0b3ee9eb309f8b96568da1ee8559',
     x86_64: 'efcabe2b2a942761a7102152bdeacb46aac1ee511d4373bcc50635121ead0e66'
  })

  depends_on 'appstream_glib'
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'enchant' # R
  depends_on 'folks'
  depends_on 'freetype'
  depends_on 'gcr_3'
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gmime'
  depends_on 'gnome_online_accounts'
  depends_on 'gsound'
  depends_on 'gspell'
  depends_on 'gtk3'
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'iso_codes'
  depends_on 'itstool' => :build
  depends_on 'json_glib' # R
  depends_on 'libgee' # R
  depends_on 'libhandy'
  depends_on 'libpeas'
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libstemmer' # R
  depends_on 'libunwind' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'sqlite'
  depends_on 'vala' => :build
  depends_on 'webkit2gtk_4_1'
  depends_on 'ytnef'

  gnome
end
