require 'package'

class Gnome_weather < Package
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '40.beta'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gnome-weather/archive/40.beta.tar.gz'
  source_sha256 '281b35ab677a143d0aa0118a2c7c3be6a76837d01ea0dd5f862c628b8ef1579a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_weather-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_weather-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_weather-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_weather-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '25aafe9b86f33ab398694d3068924e67096b1c0a7b76fae3b522debf73e1d96f',
     armv7l: '25aafe9b86f33ab398694d3068924e67096b1c0a7b76fae3b522debf73e1d96f',
       i686: 'ecc3074e962ca1e123278a4730d44bfe76b096b88b33edc8953f8a1efb8455b7',
     x86_64: 'fa99714935ad0dcb81bf158f10714ed657dcaeb4bbeec281ada143f37341633a'
  })

  depends_on 'gtk3'
  depends_on 'gjs'
  depends_on 'libgweather'
  depends_on 'geoclue'
  depends_on 'gnome_desktop'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'appstream_glib' => ':build'
  depends_on 'libhandy'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
