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
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_armv7l/libxmlb-0.3.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_armv7l/libxmlb-0.3.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_i686/libxmlb-0.3.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmlb/0.3.14_x86_64/libxmlb-0.3.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e8fc1cfaf0e7332a9fb4bb5111d60fbbe2ce33036fd1a34eb2ba8883a37c0f0',
     armv7l: '6e8fc1cfaf0e7332a9fb4bb5111d60fbbe2ce33036fd1a34eb2ba8883a37c0f0',
       i686: '4833226d07eeb7afc4ee89dd7130df5c292ba3e2c47c220c536cd73175344367',
     x86_64: '6e31fb5ded6d3c981f5e13887f284cfe36bfc941672d5f8d08f1eb8e297c5d71'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libstemmer' # R
  depends_on 'py3_pygments' => :build
  depends_on 'xzutils' # R
  depends_on 'zstd' # R

  run_tests

  meson_options '-Dstemmer=true'
end
