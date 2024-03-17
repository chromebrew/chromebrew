require 'buildsystems/meson'

class Libsoup < Meson
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '3.4.4'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb6057694da2fdf4a5d66544e2af3cdba7fd4f85ef7d9ab515df0cd59a1c0e7c',
     armv7l: 'bb6057694da2fdf4a5d66544e2af3cdba7fd4f85ef7d9ab515df0cd59a1c0e7c',
     x86_64: '3123c0f5ac768e957b0a234f9ab7834cfb117394f1e74a1ca8355e888f597ac9'
  })

  depends_on 'brotli' # R
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib_networking' => :build
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'krb5' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libsoup2' # This way we make sure packages which need the older libsoup-2.4 library get it too.
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  gnome

  meson_options '-Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled'
end
