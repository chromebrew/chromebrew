require 'package'

class Snooze < Package
  description 'run a command at a particular time'
  homepage 'https://github.com/chneukirchen/snooze/'
  version '0.2'
  compatibility 'all'
  source_url 'https://github.com/chneukirchen/snooze/archive/v0.2.tar.gz'
  source_sha256 '69242bb1534b11b569dfd1535aca20e3e6be95c6285aff1ccf612b2a9f906a1a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/snooze-0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/snooze-0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/snooze-0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/snooze-0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dfe815eda42dd1c734ca9845ec5530615c1ed61a1961f50237375d4c09df57e8',
     armv7l: 'dfe815eda42dd1c734ca9845ec5530615c1ed61a1961f50237375d4c09df57e8',
       i686: 'b2f9d6e8fe497182d763f1b300185dc01a5af6fb90b69415aa4d16cae035319c',
     x86_64: '0e8ecfdc763b5f721e68fbc4b925139a4f023c8fc4e576bd325e5819a83b6acd',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
