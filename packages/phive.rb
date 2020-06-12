require 'package'

class Phive < Package
  description 'The PHAR Installation and Verification Environment (PHIVE)'
  homepage 'https://phar.io/'
  version '0.9.0'
  compatibility 'all'
  source_url 'https://github.com/phar-io/phive/archive/0.9.0.tar.gz'
  source_sha256 '711659b2293015c1bc81755bb56746fc86f1c6c6c3b87eaaddaa56d29c86c0ad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/phive-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/phive-0.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/phive-0.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/phive-0.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3cc4a5b1b583a3fdda8df1ec7772a1982a9566fabbd1cfa2cfeb4797676a5d22',
     armv7l: '3cc4a5b1b583a3fdda8df1ec7772a1982a9566fabbd1cfa2cfeb4797676a5d22',
       i686: '696d5c1d32ae643088989767e333aa735d5b059734f7771d8c6ae87625bea314',
     x86_64: '49b75dfccdf0f14a516c67dc923603d579ea4bd9dcac49892eb483e578aaaf49',
  })

  depends_on 'composer'

  def self.install
    system "composer install"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/phive"
    system "cp -r . #{CREW_DEST_PREFIX}/share/phive"
    system "ln -s #{CREW_PREFIX}/share/phive/phive #{CREW_DEST_PREFIX}/bin/phive"
  end
end
