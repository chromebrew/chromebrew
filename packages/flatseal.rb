require 'package'

class Flatseal < Package
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal'
  version '1.6.8'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/tchx84/Flatseal/archive/v1.6.8.tar.gz'
  source_sha256 '28d05995effa2858483283cbc9fb54c55bf4dcb6267e4d7d495a32ff724806b1'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/flatseal-1.6.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/flatseal-1.6.8-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/flatseal-1.6.8-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/flatseal-1.6.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1855728c3191d4ba43ef4a71bd1c69a8de9dea8106bdb76d6b332af97a8d4aa3',
     armv7l: '1855728c3191d4ba43ef4a71bd1c69a8de9dea8106bdb76d6b332af97a8d4aa3',
       i686: '1034cde09073b2d6e482908087d3a600aa0e4bc6df71e1c0c725dde49c837508',
     x86_64: '120efb65b35bf96f2d95673202dbfb3b8f1314f4572720b76d805a280ca930db',
  })

  depends_on 'libhandy'
  depends_on 'desktop_file_utils'
  depends_on 'gjs'
  depends_on 'gtk3'
  depends_on 'sommelier'

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
