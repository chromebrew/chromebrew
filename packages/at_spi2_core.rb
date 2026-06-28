require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.60.5'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa919c360b948ce98ea6061cbd71bb5fe675aeeabb08bb37d4f824a95e7f1d81',
     armv7l: 'fa919c360b948ce98ea6061cbd71bb5fe675aeeabb08bb37d4f824a95e7f1d81',
     x86_64: 'bb79b083623b124b4d46305d720e9c530b3ffe5eb3e75b5b605bab522b7f68fc'
  })

  depends_on 'dbus' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :build
  depends_on 'libxext' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxi' => :library
  depends_on 'libxtst' => :executable
  depends_on 'libxtst' => :library

  gnome
end
