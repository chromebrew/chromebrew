require 'package'

class Gvfs < Package
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.50.4'
  license 'GPLv2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.4_armv7l/gvfs-1.50.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.4_armv7l/gvfs-1.50.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvfs/1.50.4_x86_64/gvfs-1.50.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4fb1df08690c8023ef4c8e5394256173398024567bc00d926dce0440d39539b0',
     armv7l: '4fb1df08690c8023ef4c8e5394256173398024567bc00d926dce0440d39539b0',
     x86_64: '02138741190ca5e80f5283a1f4e7d57a44e5e1222f33c14a04abdc8f5333e54b'
  })

  depends_on 'avahi' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' # R
  depends_on 'gcr_3' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' => :build
  depends_on 'libarchive' # R
  depends_on 'libcdio' => :build
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
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'polkit' # R
  depends_on 'smbclient' # R

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
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
