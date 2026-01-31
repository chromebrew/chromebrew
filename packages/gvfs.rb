require 'buildsystems/meson'

class Gvfs < Meson
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.59.1'
  license 'GPLv2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6478d69b4f5c3b243ce5354d79faccf2ba98c13f6e67668a6809fa4703574da',
     armv7l: 'b6478d69b4f5c3b243ce5354d79faccf2ba98c13f6e67668a6809fa4703574da',
     x86_64: 'a35920c552f349267837a0ac1a326ca634d4f88b1405705c7375e5e24f705f2b'
  })

  depends_on 'avahi' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gcr_4' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' => :build
  depends_on 'libarchive' # R
  depends_on 'libbluray' => :build
  depends_on 'libcdio' # R
  depends_on 'libcdio_paranoia' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgphoto' # R
  depends_on 'libgudev' # R
  depends_on 'libimobiledevice' # R
  depends_on 'libnfs' # R
  depends_on 'libplist' # R
  depends_on 'libsecret' # R
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
