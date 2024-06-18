require 'package'

class Whatsapp < Package
  description 'An unofficial WhatsApp desktop application for Linux.'
  homepage 'https://github.com/eneshecan/whatsapp-for-linux'
  version '1.6.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/eneshecan/whatsapp-for-linux.git'
  git_hashtag "v#{version}"

  depends_on 'intltool'
  depends_on 'gtkmm3'
  depends_on 'webkit2gtk_4'
  depends_on 'libayatana_appindicator'
  depends_on 'libcanberra'
  depends_on 'hunspell'

  def self.build
    system "cmake -G ninja -B builddir #{CREW_CMAKE_OPTIONS}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end