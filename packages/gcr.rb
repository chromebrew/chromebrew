require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.40.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gcr/-/archive/#{version}/gcr-#{version}.tar.bz2"
  source_sha256 '659a49bac1c713a743894845c82ef53ccc7326dcce1879b1af0ab502ec10e7ab'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.40.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.40.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0756d3e389d6414442a8991cf59fe2bc9b08aaea009ef271608da7fb0da37c0e',
     armv7l: '0756d3e389d6414442a8991cf59fe2bc9b08aaea009ef271608da7fb0da37c0e',
       i686: '70b81b9f78daf7a22cd7489819428fd48df8630e81289b3fe255a5c3b4b7dd6c',
     x86_64: '4f27f7bb81abadf2a044637b0afb286ec252107c1380291bb82e6c3d7e230aa1'
  })

  depends_on 'libgcrypt'
  depends_on 'libxslt'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'gnupg'
  depends_on 'glib'
  depends_on 'gnupg'
  depends_on 'libxslt'
  depends_on 'vala' => :build
  depends_on 'gtk3'
  depends_on 'graphite'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dgtk_doc=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
