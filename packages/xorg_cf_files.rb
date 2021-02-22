require 'package'

class Xorg_cf_files < Package
  description 'X.org cf files for use with imake builds.'
  homepage 'https://x.org'
  version '1.0.6'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/xorg-cf-files-1.0.6.tar.gz'
  source_sha256 '6d56094e5d1a6c7d7a9576ac3a0fc2c042344509ea900d59f4b23df668b96c7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_cf_files-1.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_cf_files-1.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_cf_files-1.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_cf_files-1.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6ce0bf7604e000c5972fd0057e1eda94e4f27899f4633ad48f8c2c435a7c22e',
     armv7l: 'c6ce0bf7604e000c5972fd0057e1eda94e4f27899f4633ad48f8c2c435a7c22e',
       i686: '082dc8f0fecd307984f75ffdfbd0f802d205ad747b5c62d87d1b84c1ba18b3c8',
     x86_64: '2af0fb872316fd4c37ad1f9e1eb4613daa5ada2a3133f99b1f287e9d8d6a219b',
  })

  depends_on 'font_util'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
