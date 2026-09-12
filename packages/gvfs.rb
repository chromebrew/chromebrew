require 'buildsystems/meson'

class Gvfs < Meson
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.62.0'
  license 'GPLv2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78ceebf8f3bf553c6d2ffffbfe469371a97864c6bad87cba5fcbd7689926598d',
     armv7l: '78ceebf8f3bf553c6d2ffffbfe469371a97864c6bad87cba5fcbd7689926598d',
     x86_64: '6595ca2236a4bd7f3477ed6f70477f661829bad550b0945b4eb3167dbcd41030'
  })

  depends_on 'avahi' => :executable
  depends_on 'avahi' => :library
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' => :executable
  depends_on 'fuse3' => :library
  depends_on 'gcc_lib' => :build
  depends_on 'gcr_4' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :build
  depends_on 'libarchive' => :executable
  depends_on 'libbluray' => :build
  depends_on 'libcdio' => :executable
  depends_on 'libcdio' => :library
  depends_on 'libcdio_paranoia' => :executable
  depends_on 'libcdio_paranoia' => :library
  depends_on 'libgcrypt' => :executable
  depends_on 'libgphoto' => :executable
  depends_on 'libgphoto' => :library
  depends_on 'libgudev' => :executable
  depends_on 'libgudev' => :library
  depends_on 'libimobiledevice' => :executable
  depends_on 'libimobiledevice' => :library
  depends_on 'libnfs' => :executable
  depends_on 'libnfs' => :library
  depends_on 'libplist' => :executable
  depends_on 'libplist' => :library
  depends_on 'libsecret' => :library
  depends_on 'libsoup' => :executable
  depends_on 'libsoup' => :library
  depends_on 'libxml2' => :executable
  depends_on 'libxml2' => :library
  depends_on 'polkit' => :executable
  depends_on 'polkit' => :library
  depends_on 'smbclient' => :executable
  depends_on 'smbclient' => :library

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
