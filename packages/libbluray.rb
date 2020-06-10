require 'package'

class Libbluray < Package
  description 'This library is simply a tool for playback of Blu-ray movies.'
  homepage 'https://www.videolan.org/developers/libbluray.html'
  version '1.1.2'
  compatibility 'all'
  source_url 'https://get.videolan.org/libbluray/1.1.2/libbluray-1.1.2.tar.bz2'
  source_sha256 'a3dd452239b100dc9da0d01b30e1692693e2a332a7d29917bf84bb10ea7c0b42'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libbluray-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libbluray-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libbluray-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libbluray-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2affb63f6bf45b408f27f9f52eb29d4eeed070bf0fa729f91349a70b784b4661',
     armv7l: '2affb63f6bf45b408f27f9f52eb29d4eeed070bf0fa729f91349a70b784b4661',
       i686: 'c82f5e72b2df76453d8b4c14b753096674949737b2ec94ceff888808d3727c0d',
     x86_64: 'bb71312b23ffc4aa48fe759dcc05eeb1f45f895748b5ca8ed40a319e1734ab99',
  })

  depends_on 'ant' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
