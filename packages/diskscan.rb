require 'package'

class Diskscan < Package
  description 'diskscan is intended to find sectors of a storage medium (hard disk, flash drive or pendrive, etc.) which are bad or in the process of going bad.'
  homepage 'http://blog.disksurvey.org/proj/diskscan/'
  version '0.20'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/baruch/diskscan/archive/0.20.tar.gz'
  source_sha256 '86038b3eb45fd4b2485a4ffba1949c68bea66f13a4c991265e3d527f022ed966'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '018a45cad7c7409280a44bbc59ca464cde36eb687d0795ed978d5a69dee93683',
     armv7l: '018a45cad7c7409280a44bbc59ca464cde36eb687d0795ed978d5a69dee93683',
       i686: 'fb05ea4842dc5d97f6359b0c891102e3e495c25db67f768e9b9fce83972e0c4a',
     x86_64: 'e56c72291e6dbb53b30e41a227404e6b446a37e112442d2d7463a609d577170c'
  })

  depends_on 'termcap'

  def self.build
    system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
