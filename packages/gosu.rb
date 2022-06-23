require 'package'

class Gosu < Package
  description 'Simple Go-based setuid+setgid+setgroups+exec'
  homepage 'https://github.com/tianon/gosu'
  version '1.14'
  license 'Apache-2.0'
  compatibility 'all'
  source_url ({
    aarch64: 'https://github.com/tianon/gosu/releases/download/1.14/gosu-armhf',
     armv7l: 'https://github.com/tianon/gosu/releases/download/1.14/gosu-armhf',
       i686: 'https://github.com/tianon/gosu/releases/download/1.14/gosu-i386',
     x86_64: 'https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64'
  })
  source_sha256 ({
    aarch64: 'abb1489357358b443789571d52b5410258ddaca525ee7ac3ba0dd91d34484589',
     armv7l: 'abb1489357358b443789571d52b5410258ddaca525ee7ac3ba0dd91d34484589',
       i686: 'fa12da9c07783fe5fb2c2a81b5d4277eec7615c957a0b0cce3f14802ff9372e7',
     x86_64: 'bd8be776e97ec2b911190a82d9ab3fa6c013ae6d3121eea3d0bfd5c82a0eaf8c'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install Dir['gosu-*'][0], "#{CREW_DEST_PREFIX}/bin/gosu", mode: 0o755
  end
end
