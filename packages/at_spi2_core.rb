require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.48.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag "AT_SPI2_CORE_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b43962dd48f8cedaa964eb5598e32ef05b7a929c09917cbc3e06e204da059de',
     armv7l: '8b43962dd48f8cedaa964eb5598e32ef05b7a929c09917cbc3e06e204da059de',
       i686: 'ce843f4c9b133c03a79f6aa627e33931ad3578c11ed3f7c60d6c87346e3c79da',
     x86_64: '618d2c9f7bd2216ac20411ae750a324de992d60dc3ecab519ad247a2a82af344'
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

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
