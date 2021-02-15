require 'package'

class Bz2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'https://gitlab.com/federicomenaquintero/bzip2/'
  version '1.0.7-6211'
  compatibility 'all'
  source_url 'https://gitlab.com/federicomenaquintero/bzip2/-/archive/6211b6500c8bec13a17707440d3a84ca8b34eed5/bzip2-6211b6500c8bec13a17707440d3a84ca8b34eed5.tar.bz2'
  source_sha256 'a374472b955db5194c236d38d53c5d56dd1035f1c735941503228b16065a08b3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.7-6211-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.7-6211-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.7-6211-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.7-6211-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fb273654412a427737f20bf369104c8dd13aa5b367bc847657e4eb71d40574b1',
     armv7l: 'fb273654412a427737f20bf369104c8dd13aa5b367bc847657e4eb71d40574b1',
       i686: 'df400e541bdf375878fed304ca3b9e1faad458f0ec8f717851f7b8bc5f3eea7d',
     x86_64: 'a8cd2fb0d892f298f614c15980f5f0be9a7c65a964ddaef3c092fd6596c6ca97'
  })

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
