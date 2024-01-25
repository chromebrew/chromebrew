require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/gjs/'
  version '1.74.0'
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06cec6c34dc4656735a526af6d74d02452dd34de1654c46efd327a5c80932982',
     armv7l: '06cec6c34dc4656735a526af6d74d02452dd34de1654c46efd327a5c80932982',
       i686: 'c1b996c78fd6ab6ca1419101d1e63cff1726c458275bac1e2084ae40f3a7dfad',
     x86_64: 'decdaf546dac3ccee260617d756619892cd443f6b42c19b56318feae913cc31e'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'js102'
  depends_on 'libx11' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dskip_gtk_tests=true \
    -Dprofiler=disabled \
    -Dreadline=disabled \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
