require 'buildsystems/meson'

class Libsoup < Meson
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '3.6.5'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '532688450c93709b5a6adb69750c460808050aeb1025956c9c9090d0f0e36694',
     armv7l: '532688450c93709b5a6adb69750c460808050aeb1025956c9c9090d0f0e36694',
     x86_64: 'ac2c8a4ffc06a61e2ba2971b9c5d923686699ca09b267b8b539bf741afdd6c49'
  })

  depends_on 'brotli' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glib_networking' => :build
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'krb5' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libsoup2' # This way we make sure packages which need the older libsoup-2.4 library get it too.
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  gnome

  meson_options '-Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled'
end
