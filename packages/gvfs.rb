require 'package'

class Gvfs < Package
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  @_ver = '1.48.0'
  version "#{@_ver}-1"
  license 'GPLv2'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gvfs/-/archive/#{@_ver}/gvfs-#{@_ver}.tar.bz2"
  source_sha256 'acde26bee8a04e8432b0946b0fd36bc831ccc4f58c32fbcee6a3f525a595f5e9'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/gvfs-1.48.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/gvfs-1.48.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/gvfs-1.48.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/gvfs-1.48.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '97b9379b27f4005491a2737d7f549d750a8c7b7cb4939cf423e610306e888a66',
     armv7l: '97b9379b27f4005491a2737d7f549d750a8c7b7cb4939cf423e610306e888a66',
       i686: '7b1c91a1b4004bdee1904e5dda3fb4a57626c953105dc5ca65ba1d1f1604e9bf',
     x86_64: '58d2e873fcd548ed212466b098f24925abb05e6e3a5fc76e5cbecfe42f3661a6'
  })

  depends_on 'avahi'
  depends_on 'dbus' => :build
  depends_on 'dconf'
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3'
  depends_on 'gcr'
  depends_on 'glib'
  depends_on 'gtk3' => :build
  depends_on 'libarchive'
  depends_on 'libcdio'
  depends_on 'libcdio_paranoia'
  depends_on 'libgcrypt'
  depends_on 'libgphoto'
  depends_on 'libgudev'
  depends_on 'libimobiledevice'
  depends_on 'libnfs'
  depends_on 'libplist'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'polkit'
  depends_on 'smbclient'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dfuse=true \
    -Dgoa=false \
    -Dgoogle=false \
    -Dmtp=false \
    -Dsystemduserunitdir=no \
    -Dtmpfilesdir=no \
    -Dudisks2=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
