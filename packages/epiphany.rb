# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'package'

class Epiphany < Package
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '43.0'
  license 'GPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/epiphany.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/epiphany/43.0_armv7l/epiphany-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/epiphany/43.0_armv7l/epiphany-43.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/epiphany/43.0_x86_64/epiphany-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd494c6e107ea6fb881b5d28ff67fa3e6ec2f6091ce4b8e00e3c6253d4d3de7cb',
     armv7l: 'd494c6e107ea6fb881b5d28ff67fa3e6ec2f6091ce4b8e00e3c6253d4d3de7cb',
     x86_64: '143a6f9be5dbd4df49fee28c43ae4eabfc7820cffacf186e9d729f7eb6572ae2'
  })

  depends_on 'atk' # R
  depends_on 'cairo' # R
  depends_on 'docbook_xml' => :build
  depends_on 'freetype' => :build
  depends_on 'gcr' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gmp' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'help2man' => :build
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' # R
  depends_on 'libdazzle' # R
  depends_on 'libhandy' # R
  depends_on 'libportal' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'lsb_release' => :build
  depends_on 'pango' # R
  depends_on 'startup_notification' => :build
  depends_on 'valgrind' => :build
  depends_on 'webkit2gtk_4' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'at_spi2_core' # R
  depends_on 'gcr_3' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libarchive' # R
  depends_on 'libxml2' # R
  depends_on 'nettle' # R
  depends_on 'sqlite' # R
  depends_on 'gcc' # R
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
  end
end
