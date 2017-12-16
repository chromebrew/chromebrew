require 'package'

class Health_check < Package
  description 'The health-check tool monitors processes in various ways to help identify areas where it is consuming too many resources.'
  homepage 'http://kernel.ubuntu.com/~cking/health-check/'
  version '0.02.08'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/health-check/health-check-0.02.08.tar.gz'
  source_sha256 'be4f14affaa80dc634cc4cf41efc0b3164e5b1758674762f0a2322d2ccbfbd52'

  binary_url ({
  })
  binary_sha256 ({
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
