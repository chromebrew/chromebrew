require 'package'

class Flatseal < Package
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal/'
  @_ver = '1.7.5'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/tchx84/Flatseal.git'
  git_hashtag 'v' + @_ver

  depends_on 'libhandy'
  depends_on 'desktop_file_utils'
  depends_on 'gjs'
  depends_on 'gtk3'
  depends_on 'webkit2gtk'
  depends_on 'sommelier'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.symlink 'com.github.tchx84.Flatseal', "#{CREW_DEST_PREFIX}/bin/flatseal"
  end
end
