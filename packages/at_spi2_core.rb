require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://www.freedesktop.org/wiki/'
  version '2.56.2'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf387add7cd4760328d40a0b11fa07ec565d22b50531f75fef9b4360a0096b75',
     armv7l: 'cf387add7cd4760328d40a0b11fa07ec565d22b50531f75fef9b4360a0096b75',
     x86_64: '58f82f9ccd5beee13c8209bed7a5dcb10696b6b00708dde0fa3ed9750cea5175'
  })

  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' => :build
  depends_on 'libxext' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxi' # R
  depends_on 'libxtst' # R

  gnome
end
