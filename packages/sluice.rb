require 'package'

class Sluice < Package
  description 'Sluice is a program that reads input on stdin and outputs on stdout at a specified data rate.'
  homepage 'http://kernel.ubuntu.com/~cking/sluice/'
  version '0.02.08'
  compatibility 'all'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/sluice/sluice-0.02.08.tar.gz'
  source_sha256 'c1fc8093f93bc376d494883f3302749fcf46a1041baab6c3304ef6185f9c1569'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b0cab6d3faaff309e4c81f16b81873c44968a1fca5b89996116c5a53cdf0eef3',
     armv7l: 'b0cab6d3faaff309e4c81f16b81873c44968a1fca5b89996116c5a53cdf0eef3',
       i686: '6539f7c68e21409f6b4bbb03bff5b1e70c578290fb7d0f9ee20e2bfa1b2f6cf5',
     x86_64: 'aa22286d0331082d72c65670f8550ae11c74e348ff8fe873247d5b1df011612e',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
