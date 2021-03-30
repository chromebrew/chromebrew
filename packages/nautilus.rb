# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  @_ver = '40.0'
  version @_ver
  license 'GPLv3'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/nautilus/-/archive/#{@_ver}/nautilus-#{@_ver}.tar.bz2"
  source_sha256 '9bcb93c5ce56dbe1cd2b2d0808c21a5e37cc1d098ee037b7da75c0a4a59e84e7'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nautilus-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nautilus-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nautilus-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nautilus-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7343e4245acf8b1bce3c8ad9208a6d3981edc0bb7997071758c7223399334c65',
     armv7l: '7343e4245acf8b1bce3c8ad9208a6d3981edc0bb7997071758c7223399334c65',
       i686: '286c26c5c8b89a8a52ff7ee8f55b516207447471868b311cf8c206722555158b',
     x86_64: 'bae97c6259459844e5cf945160e162734edbc66ce50eb3965e1c55b9932a6564'
  })

  depends_on 'gexiv2'
  depends_on 'gnome_autoar'
  depends_on 'gnome_desktop'
  depends_on 'gvfs'
  depends_on 'dconf'
  depends_on 'libhandy'
  depends_on 'libportal'
  depends_on 'tracker3'
  depends_on 'tracker3_miners'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'appstream_glib' => :build

  def self.patch
    # Source has libgnome-volume-control repo as submodule
    @git_dir = 'subprojects/libgd'
    @git_hash = 'c7c7ff4e05d3fe82854219091cf116cce6b19de0'
    @git_url = 'https://gitlab.gnome.org/GNOME/libgd.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Ddocs=false \
    -Dpackagekit=false \
    -Dnetworkmanager=false \
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
