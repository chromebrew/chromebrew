require 'package'

class Faad2 < Package
  description 'ISO AAC audio decoder'
  homepage 'https://github.com/knik0/faad2'
  @_ver = '2.10.0'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/knik0/faad2/archive/2_10_0.tar.gz'
  source_sha256 '0c6d9636c96f95c7d736f097d418829ced8ec6dbd899cc6cc82b728480a84bfb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/faad2-2.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/faad2-2.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/faad2-2.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/faad2-2.10.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '61e4cfcd34bbedcb9cb3abea2a5bb73f57027319665c96eade68f0cf80e913e0',
     armv7l: '61e4cfcd34bbedcb9cb3abea2a5bb73f57027319665c96eade68f0cf80e913e0',
       i686: 'e816286dbfe694b8a6b5c1014772aa14b664c64fe76f759f218142a57d31596a',
     x86_64: 'b88cde37bb9e6cbf2a60c4b4249741becf3a8cf5c4139bdbd11bd56d6079f3d9'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system 'autoreconf -vfi'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
