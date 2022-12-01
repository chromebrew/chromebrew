require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.46.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag "AT_SPI2_CORE_#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.46.0_armv7l/at_spi2_core-2.46.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.46.0_armv7l/at_spi2_core-2.46.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.46.0_i686/at_spi2_core-2.46.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/at_spi2_core/2.46.0_x86_64/at_spi2_core-2.46.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e41f66f60dc1cf250c5261fbb273a28235de94f07eb7875b47e7e911952f07f3',
     armv7l: 'e41f66f60dc1cf250c5261fbb273a28235de94f07eb7875b47e7e911952f07f3',
       i686: '84715693ae536e4971ed770b0c8b4dfe3ba9b01672c18608ba962c7acd225318',
     x86_64: '34da69bd9bc905ca3cd2fcd57bb2f2acfdb91ce7cc0fb48dd2bb02c8acada64b'
  })

  depends_on 'libxtst'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'libxcb'
  depends_on 'gtk_doc'
  depends_on 'atk' # R
  depends_on 'at_spi2_atk' # R
  depends_on 'glibc' # R
  depends_on 'libxext' # R
  depends_on 'libx11' # R
  depends_on 'libxi' # R
  depends_on 'gcc' # R

  conflicts_ok # Doesn't actually conflict with atk
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
