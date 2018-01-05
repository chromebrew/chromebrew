require 'package'

class Snooze < Package
  description 'run a command at a particular time'
  homepage 'https://github.com/chneukirchen/snooze/'
  version '0.2'
  source_url 'https://github.com/chneukirchen/snooze/archive/v0.2.tar.gz'
  source_sha256 '69242bb1534b11b569dfd1535aca20e3e6be95c6285aff1ccf612b2a9f906a1a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
