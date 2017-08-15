require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'http://pacparser.manugarg.com/'
  version '1.3.7'
  source_url 'https://github.com/pacparser/pacparser/archive/1.3.7.tar.gz'
  source_sha256 '575c5d8096b4c842b2af852bbb8bcfde96170b28b49f33249dbe2057a8beea13'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pacparser-1.3.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pacparser-1.3.7-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pacparser-1.3.7-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pacparser-1.3.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ef59a07d70de04af1dfa29d0f441bd2bf887df09aa9c59ab0c27e3712a06d19',
     armv7l: '5ef59a07d70de04af1dfa29d0f441bd2bf887df09aa9c59ab0c27e3712a06d19',
       i686: '69f365dfb839bda6241ace5f9bf65b56bbd871742625dac80cd5c9b047d26880',
     x86_64: '0276d2c3ac06bfd652171ac7db21f40324b8bc58b1f62ef7adf7e0472dd4f657',
  })

  def self.build
    system "make -C src"
  end

  def self.install
    system "PREFIX=/usr/local make -C src install"
  end
end
