require 'package'

class Libayatana_ido < Package
  description 'Ayatana Indicator Display Objects'
  homepage 'https://github.com/AyatanaIndicators/ayatana-ido'
  version '0.10.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/AyatanaIndicators/ayatana-ido.git'
  git_hashtag version

  depends_on 'gtk3'
  depends_on 'glib'

  def self.build
    system "cmake -G ninja -B builddir #{CREW_CMAKE_OPTIONS}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end