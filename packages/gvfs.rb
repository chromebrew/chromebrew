require 'buildsystems/meson'

class Gvfs < Meson
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.54.0'
  license 'GPLv2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fb1df08690c8023ef4c8e5394256173398024567bc00d926dce0440d39539b0',
     armv7l: '4fb1df08690c8023ef4c8e5394256173398024567bc00d926dce0440d39539b0',
     x86_64: '02138741190ca5e80f5283a1f4e7d57a44e5e1222f33c14a04abdc8f5333e54b'
  })

  depends_on 'avahi' => :build
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gcr_3' => :build
  depends_on 'gcr' => :build
  depends_on 'glibc' => :build
  depends_on 'glib' => :build
  depends_on 'gtk3' => :build
  depends_on 'libarchive' => :build
  depends_on 'libcdio' => :build
  depends_on 'libcdio_paranoia' => :build
  depends_on 'libcdio' => :build
  depends_on 'libgcrypt' => :build
  depends_on 'libgphoto' => :build
  depends_on 'libgudev' => :build
  depends_on 'libimobiledevice' => :build
  depends_on 'libnfs' => :build
  depends_on 'libplist' => :build
  depends_on 'libsecret' => :build
  depends_on 'libsoup2' => :build
  depends_on 'libsoup' => :build
  depends_on 'libxml2' => :build
  depends_on 'polkit' => :build
  depends_on 'smbclient' => :build

  gnome

  meson_options '-Dfuse=true \
    -Dgoa=false \
    -Dgoogle=false \
    -Dmtp=false \
    -Dsystemduserunitdir=no \
    -Dtmpfilesdir=no \
    -Dudisks2=false'
end
