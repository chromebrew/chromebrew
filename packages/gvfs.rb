require 'buildsystems/meson'

class Gvfs < Meson
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.59.90'
  license 'GPLv2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dd31cc0303289305e3f7605171f1aa5040b045aac30772044c8773ffa6c82c6',
     armv7l: '7dd31cc0303289305e3f7605171f1aa5040b045aac30772044c8773ffa6c82c6',
     x86_64: '031d960184bd78c87c688711804a9dce53161edf03d60ea36548e9cec25c4a2d'
  })

  depends_on 'avahi' # R
  depends_on 'avahi' => :executable_only
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' # R
  depends_on 'fuse3' => :executable_only
  depends_on 'gcc_lib' => :build
  depends_on 'gcr_4' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' => :build
  depends_on 'libarchive' # R
  depends_on 'libarchive' => :executable_only
  depends_on 'libbluray' => :build
  depends_on 'libcdio' # R
  depends_on 'libcdio' => :executable_only
  depends_on 'libcdio_paranoia' # R
  depends_on 'libcdio_paranoia' => :executable_only
  depends_on 'libgcrypt' # R
  depends_on 'libgcrypt' => :executable_only
  depends_on 'libgphoto' # R
  depends_on 'libgphoto' => :executable_only
  depends_on 'libgudev' # R
  depends_on 'libgudev' => :executable_only
  depends_on 'libimobiledevice' # R
  depends_on 'libimobiledevice' => :executable_only
  depends_on 'libnfs' # R
  depends_on 'libnfs' => :executable_only
  depends_on 'libplist' # R
  depends_on 'libplist' => :executable_only
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libsoup' => :executable_only
  depends_on 'libxml2' # R
  depends_on 'libxml2' => :executable_only
  depends_on 'polkit' # R
  depends_on 'polkit' => :executable_only
  depends_on 'smbclient' # R
  depends_on 'smbclient' => :executable_only

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
