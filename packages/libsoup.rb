require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '3.4.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc98bf1ea4739fde2b7fdf2c9d90c8d072294955907354a518456c22968da689',
     armv7l: 'cc98bf1ea4739fde2b7fdf2c9d90c8d072294955907354a518456c22968da689',
       i686: '61a01150af6fd7d6a1343f94b50237dba373ef80a7c0661651930e01f66a5191',
     x86_64: '8279f8edabc965a590b260fcc34543b0f25b66a4746e3dd89befcd4b0046b91b'
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
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
