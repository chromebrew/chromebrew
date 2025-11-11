require 'buildsystems/meson'

class Libsoup2 < Meson
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.74.3'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '909d1685817a2bbbfacea4b320d87ee12b76e10d0125a8be7a09d809a5d55b5a',
     armv7l: '909d1685817a2bbbfacea4b320d87ee12b76e10d0125a8be7a09d809a5d55b5a',
     x86_64: 'b7c8a66c48dfdf3a295bbd0119b45c1029f9e534ac7d164d08e07c6586f6fb52'
  })

  depends_on 'brotli' # R
  depends_on 'glib' # R
  depends_on 'glib_networking'
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libevent'
  depends_on 'libpsl' # R
  depends_on 'libxml2' # R
  depends_on 'sqlite' # R
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  gnome

  meson_options "-Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled"
end
