# Adapted from Arch Linux libxmlb PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libxmlb/trunk/PKGBUILD

require 'buildsystems/meson'

class Libxmlb < Meson
  description 'Library to help create and query binary XML blobs'
  homepage 'https://github.com/hughsie/libxmlb'
  version '0.3.24'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hughsie/libxmlb.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '515b9b44b6a92a49ec8cb40617eeb50caa854e0d09b77a44b95fe15e2b1f2868',
     armv7l: '515b9b44b6a92a49ec8cb40617eeb50caa854e0d09b77a44b95fe15e2b1f2868',
       i686: '44712fec86321e6e6b33c21a0e74c5c8c13cd6fe27b8cd8210b457c78905ecb8',
     x86_64: '4912f8ce873af0be7f0ecb374248d8959a47d11c611f5e7fbcbdc04d28761ec4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libstemmer' # R
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'xzutils' # R
  depends_on 'zstd' # R

  run_tests

  meson_options '-Dintrospection=false -Dstemmer=true'
end
