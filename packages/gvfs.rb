require 'package'

class Gvfs < Package
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  @_ver = '1.50.2'
  version @_ver
  license 'GPLv2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.2_armv7l/gvfs-1.50.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.2_armv7l/gvfs-1.50.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.2_i686/gvfs-1.50.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.2_x86_64/gvfs-1.50.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '32879178b42dcc09ee6fc932eb05127fa23b8331add08f225a8a0ca5f51368cd',
     armv7l: '32879178b42dcc09ee6fc932eb05127fa23b8331add08f225a8a0ca5f51368cd',
       i686: '044bb14dcb792ca02baee2bebc2ba7334efb6e3995e44ef0cbd79ccebdb7e14f',
     x86_64: 'd9ef574da4c1d7153eb2ec1cc7bd339c96dcf7c9910f875acfc745d8f771815b'
  })

  depends_on 'avahi' # R
  depends_on 'dbus' => :build
  depends_on 'dconf'
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' # R
  depends_on 'gcr_3' # R
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
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
