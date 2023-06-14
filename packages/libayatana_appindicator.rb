require 'package'

class Libayatana_appindicator < Package
  description 'A library to allow applications to export a menu into the an Application Indicators aware menu bar.'
  homepage 'https://github.com/AyatanaIndicators/libayatana-appindicator'
  version '0.5.92'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/AyatanaIndicators/libayatana-appindicator.git'
  git_hashtag version

  depends_on 'libayatana_indicator'
  depends_on 'gtk3'
  depends_on 'glib'
  depends_on 'libdbusmenu_gtk3'

  def self.build
    system "cmake -G ninja -B builddir #{CREW_CMAKE_OPTIONS}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end