require 'package'

class Libayatana_indicator < Package
  description 'The Ayatana Indicators project is the continuation of Application Indicators and System Indicators.'
  homepage 'https://github.com/AyatanaIndicators/libayatana-indicator'
  version '0.9.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/AyatanaIndicators/libayatana-indicator.git'
  git_hashtag version

  depends_on 'gtk3'
  depends_on 'glib'
  depends_on 'libayatana_ido'

  def self.build
    system "cmake -G ninja -B builddir #{CREW_CMAKE_OPTIONS}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end