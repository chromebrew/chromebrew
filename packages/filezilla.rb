require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.50.0'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.50.0_src.tar.bz2'
  source_sha256 'e0db87269ca5208aad14a02415337b4f9efe3c49c2d4d14e66e921c78a135c10'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.50.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.50.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.50.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.50.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '65db514c90a9b9255985c3175d2a19b66c7f9c5924c8651aea788e12abafcdf6',
     armv7l: '65db514c90a9b9255985c3175d2a19b66c7f9c5924c8651aea788e12abafcdf6',
       i686: '82cb9f2f8ca314d7e558017794d3e38df39103cb4d24ed0623b01d7ff3a3472c',
     x86_64: '42a7b7c6fe4c7f2e07cd029d720663e5e78b891427d4b1440f355ba6aa5d3604',
  })

  depends_on 'dbus'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'libfilezilla'
  depends_on 'libidn2'
  depends_on 'sqlite'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
    FileUtils.mv 'bin/filezilla', 'bin/filezilla_orig'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "cat <<'EOF'> filezilla
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/filezilla_orig $@
EOF"
    system "install -Dm755 filezilla #{CREW_DEST_PREFIX}/bin/filezilla"
  end
end
