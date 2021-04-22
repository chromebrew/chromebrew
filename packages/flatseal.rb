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
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/flatseal-1.6.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/flatseal-1.6.8-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/flatseal-1.6.8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/flatseal-1.6.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de9d7364712c7e4fe13be61be7b3e961fc7fc792e65d87a3fbb0b95612bc9e11',
     armv7l: 'de9d7364712c7e4fe13be61be7b3e961fc7fc792e65d87a3fbb0b95612bc9e11',
       i686: '5335cf616a038715fc851a49b07c32c79bdcf087167898e5951d0dc8c7f365c6',
     x86_64: '8522129c645e74b4696f552cffa5d16a17e6ccdc180d4150fbb34e680220eade',
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
