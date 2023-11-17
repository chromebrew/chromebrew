# Adapted from Arch Linux libxmlb PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libxmlb/trunk/PKGBUILD

require 'buildsystems/meson'

class Libxmlb < Meson
  description 'Library to help create and query binary XML blobs'
  homepage 'https://github.com/hughsie/libxmlb'
  version '0.3.14'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hughsie/libxmlb.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_armv7l/libxmlb-0.3.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_armv7l/libxmlb-0.3.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_i686/libxmlb-0.3.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_x86_64/libxmlb-0.3.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c63785e43de4d1761d560dfb928a87811cdfacabca418a69cc85e3478db50dca',
     armv7l: 'c63785e43de4d1761d560dfb928a87811cdfacabca418a69cc85e3478db50dca',
       i686: 'e61e0fc258310c2e294ecc12f5028129a855ba6e68f3cbaceeaa61cb457a8f9e',
     x86_64: '2c94f36118889be247c3dcbf2e871dac303770aef92b04c3b1b0d9237c25d2fb'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libstemmer' # R
  depends_on 'py3_pygments' => :build
  depends_on 'xzutils' # R
  depends_on 'zstd' # R

  meson_options '-Dstemmer=true \
    -Dtests=false'
end
