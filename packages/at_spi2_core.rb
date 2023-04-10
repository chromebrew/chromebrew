require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.47.90'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag "AT_SPI2_CORE_#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.47.90_armv7l/at_spi2_core-2.47.90-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.47.90_armv7l/at_spi2_core-2.47.90-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.47.90_i686/at_spi2_core-2.47.90-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.47.90_x86_64/at_spi2_core-2.47.90-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a2c7a6a2940417efd641837d8613070cde1db49a9472c614e02cb1976d95d89d',
     armv7l: 'a2c7a6a2940417efd641837d8613070cde1db49a9472c614e02cb1976d95d89d',
       i686: '3f188d3d336b7e5bdf1e1754a4679b8da0b2750b1332b28fd6874dd1fb61aaae',
     x86_64: 'e68621afe44bef2d25c45026c2cd08b4cf6d707aa2100dcde61d8594a6bec4fe'
  })

  depends_on 'dbus' # R
  depends_on 'gcc' # R
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

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
