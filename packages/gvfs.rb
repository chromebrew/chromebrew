require 'package'

class Gvfs < Package
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.48.0'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gvfs/-/archive/#{version}/gvfs-#{version}.tar.bz2"
  source_sha256 'acde26bee8a04e8432b0946b0fd36bc831ccc4f58c32fbcee6a3f525a595f5e9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gvfs-1.48.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gvfs-1.48.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gvfs-1.48.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gvfs-1.48.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cf218af397be4007617a4741306d2b45eac1f164560532dd0525ba7be629f5b0',
     armv7l: 'cf218af397be4007617a4741306d2b45eac1f164560532dd0525ba7be629f5b0',
       i686: '12893026e752bbb6bd328a19e9ae44879e331db1f333f4a9b6e69b51dedd8976',
     x86_64: '54a45a21769ac7853b0cebfa4f9ae78a88da00d59235c7974c2e6f64a98293ec'
  })

  depends_on 'avahi'
  depends_on 'dbus' => :build
  depends_on 'dconf'
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse'
  depends_on 'gcr'
  depends_on 'gtk3' => :build
  depends_on 'libarchive'
  depends_on 'libcdio_paranoia'
  depends_on 'libgphoto' => :build
  depends_on 'libgudev' => :build
  depends_on 'libimobiledevice' => :build
  depends_on 'libnfs'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'smbclient' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dfuse=false \
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
