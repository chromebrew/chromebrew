require 'buildsystems/meson'

class Gvfs < Meson
  description 'Virtual filesystem implementation for GIO'
  homepage 'https://wiki.gnome.org/Projects/gvfs'
  version '1.60.0'
  license 'GPLv2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gvfs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be34d04edca23dac2a608413a870bfcc9d34b6ebf1f5ce6752a5d9aa7cdcb60d',
     armv7l: 'be34d04edca23dac2a608413a870bfcc9d34b6ebf1f5ce6752a5d9aa7cdcb60d',
     x86_64: 'a1c5dd80d8be87511e2b31890fb9597853e3bdacf8c155191806b901082322f6'
  })

  depends_on 'avahi' => :executable_only
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'elogind' => :build
  depends_on 'fuse3' => :executable_only
  depends_on 'gcc_lib' => :build
  depends_on 'gcr_4' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :build
  depends_on 'libarchive' => :executable_only
  depends_on 'libbluray' => :build
  depends_on 'libcdio' => :executable_only
  depends_on 'libcdio_paranoia' => :executable_only
  depends_on 'libgcrypt' => :executable_only
  depends_on 'libgphoto' => :executable_only
  depends_on 'libgudev' => :executable_only
  depends_on 'libimobiledevice' => :executable_only
  depends_on 'libnfs' => :executable_only
  depends_on 'libplist' => :executable_only
  depends_on 'libsecret' => :library
  depends_on 'libsoup' => :executable_only
  depends_on 'libxml2' => :executable_only
  depends_on 'polkit' => :executable_only
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
