require 'package'

class Health_check < Package
  description 'The health-check tool monitors processes in various ways to help identify areas where it is consuming too many resources.'
  homepage 'http://kernel.ubuntu.com/~cking/health-check/'
  version '0.02.08'
  compatibility 'all'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/health-check/health-check-0.02.08.tar.gz'
  source_sha256 'be4f14affaa80dc634cc4cf41efc0b3164e5b1758674762f0a2322d2ccbfbd52'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/health_check-0.02.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/health_check-0.02.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/health_check-0.02.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/health_check-0.02.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1bed3ca7034d5e94be02ceecd5ddf14ce7faf8abcee1c9de3c6053ae8eabd179',
     armv7l: '1bed3ca7034d5e94be02ceecd5ddf14ce7faf8abcee1c9de3c6053ae8eabd179',
       i686: '823e9b541b221ab9d6f8d7a790952fa70f3862d60c3444e778803e0161b3b34b',
     x86_64: '7cbdce7237b0d8a6dcfeabf7cc143c08111af98875e83cb441346769cdbfa033',
  })

  depends_on 'jsonc'

  def self.build
    system "make"
    system "gzip -9 health-check.8"
  end

  def self.install
    system "install -Dm755 health-check #{CREW_DEST_PREFIX}/bin/health-check"
    system "install -Dm644 health-check.8.gz #{CREW_DEST_PREFIX}/share/man/man8/health-check.8.gz"
  end
end
