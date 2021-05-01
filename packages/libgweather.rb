require 'package'

class Libgweather < Package
  description 'Location and timezone database and weather-lookup library'
  homepage 'https://wiki.gnome.org/Projects/LibGWeather'
  version '40.beta'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libgweather/archive/40.beta.tar.gz'
  source_sha256 '89eebe5a83177f094c017a484be3a27b5e418fec2d9aaea1937bdc6ddc430627'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/40.beta_armv7l/libgweather-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/40.beta_armv7l/libgweather-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/40.beta_i686/libgweather-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/40.beta_x86_64/libgweather-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'eb3d11bb2bd6fcc03b232c52e018851ae3e4aa6008dc4676c3f99218a6a62b77',
     armv7l: 'eb3d11bb2bd6fcc03b232c52e018851ae3e4aa6008dc4676c3f99218a6a62b77',
       i686: '544a1b6fe84b39e108bb4baeec800d8b3e84796c738b445d7e5a95d2bf2e843e',
     x86_64: 'fd210e31135860d1e84e55ddbc64ada18deb731b7815e3471d78e00b24e56ee3'
  })

  depends_on 'libsoup'
  depends_on 'gtk3'
  depends_on 'geocode_glib'
  depends_on 'dconf'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glade' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
