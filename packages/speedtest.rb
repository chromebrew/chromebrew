require 'package'

class Speedtest < Package
  description 'Command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli'
  version '2.0.2'
  compatibility 'all'
  source_url 'https://github.com/sivel/speedtest-cli/archive/v2.0.2.tar.gz'
  source_sha256 '5e22f2dcce1c9020f33faf559b22727483f022008a2912b85d573e578374b6a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e6c9be7bd7b74ad375057949f5acd2db7d1f02ff6a38621a6cf516f5f60593f',
     armv7l: '5e6c9be7bd7b74ad375057949f5acd2db7d1f02ff6a38621a6cf516f5f60593f',
       i686: '36b1fca2c869a34579415190fa674355dae47afe17dc505866eccec95eea7f27',
     x86_64: '6245d2d291cb83d4fa4e51fbd867cd956df98209d2ad37237463e44c4c482fcc',
  })

  depends_on 'setuptools'

  def self.install
    system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I speedtest-cli==2.0.2"
  end
end
