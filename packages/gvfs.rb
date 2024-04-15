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
    aarch64: '4d61f624b27f9ae4ba91296fbe6646f7a076fd1e6a19ae7104e3fadff5afe491',
     armv7l: '4d61f624b27f9ae4ba91296fbe6646f7a076fd1e6a19ae7104e3fadff5afe491',
     x86_64: 'f744e878e93ef167663a59f2bed8c69dc77544ba35fe3b32d33752ff623417d8'
  })

  depends_on 'avahi' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gcr_4' # R
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
  depends_on 'libsoup2' => :build
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'polkit' # R
  depends_on 'smbclient' # R

  gnome

  meson_options '-Dfuse=true \
    -Dgoa=false \
    -Dgoogle=false \
    -Dmtp=false \
    -Donedrive=false \
    -Dsystemduserunitdir=no \
    -Dtmpfilesdir=no \
    -Dudisks2=false'
end
