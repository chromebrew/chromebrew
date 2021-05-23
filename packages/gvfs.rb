require 'package'

class Gvfs < Package
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  @_ver = '1.48.1'
  version @_ver
  license 'GPLv2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.48.1_armv7l/gvfs-1.48.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.48.1_armv7l/gvfs-1.48.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.48.1_i686/gvfs-1.48.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.48.1_x86_64/gvfs-1.48.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3585ea23719cf4e3c3da8c84beed3df3f020a91feb3d3af7f05e81514cec1e21',
     armv7l: '3585ea23719cf4e3c3da8c84beed3df3f020a91feb3d3af7f05e81514cec1e21',
       i686: 'b617653b15b4c87f2759c36067f638b70e501f4ecf01243b6ae6ef1ced47b314',
     x86_64: '5094180c75e7e99ac78a191935a6d0af41a50bf4dbcd7764bea96d7114282b19'
  })

  depends_on 'avahi' # R
  depends_on 'dbus' => :build
  depends_on 'dconf'
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' # R
  depends_on 'gcr' # R
  depends_on 'glib' # R
  depends_on 'gtk3' => :build
  depends_on 'libcdio'
  depends_on 'libcdio_paranoia' # R
  depends_on 'libcdio' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgphoto' # R
  depends_on 'libgudev' # R
  depends_on 'libimobiledevice' # R
  depends_on 'libnfs' # R
  depends_on 'libplist' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup2' # R
  depends_on 'polkit' # R
  depends_on 'smbclient' # R

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
