require 'package'

class Flatseal < Package
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal'
  version '1.6.8'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/tchx84/Flatseal/archive/v1.6.8.tar.gz'
  source_sha256 '28d05995effa2858483283cbc9fb54c55bf4dcb6267e4d7d495a32ff724806b1'

  depends_on 'libhandy'
  depends_on 'desktop_file_utils'
  depends_on 'gjs'
  depends_on 'gtk3'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "samu -C builddir"
  end

  def self.check
    system "samu -C builddir test"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.symlink 'com.github.tchx84.Flatseal', "#{CREW_DEST_PREFIX}/bin/flatseal"
  end
end
