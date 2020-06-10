require 'package'

class Ibmonitor < Package
  description 'ibmonitor is an interactive bandwidth monitor console application.'
  homepage 'http://ibmonitor.sourceforge.net/'
  version '1.4'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/ibmonitor/ibmonitor/v1.4/ibmonitor-1.4.tar.gz'
  source_sha256 '331dac4553b5c336d1db3d35176ecebeaf15b39ad0432372cba583324a222e28'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ibmonitor-1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ibmonitor-1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ibmonitor-1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ibmonitor-1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '22735764b4c6c9d973dffa60110c138f6a0b1cc2d9a7dae43f87d02f47c0028c',
     armv7l: '22735764b4c6c9d973dffa60110c138f6a0b1cc2d9a7dae43f87d02f47c0028c',
       i686: 'c3b22b076844102544be601716e5225021c411ae31487551e0adc03dbabe2c5a',
     x86_64: '1c56681a1f5c22ccd9bb42a0610937e0097371503ac1d8dd599c7cf945948009',
  })

  depends_on 'filecmd'
  depends_on 'perl_read_key'
  depends_on 'perl_term_ansicolor'
  depends_on 'perl_time_hires'

  def self.build
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' ibmonitor"
  end

  def self.install
    system "install -Dm755 ibmonitor #{CREW_DEST_PREFIX}/bin/ibmonitor"
  end
end
