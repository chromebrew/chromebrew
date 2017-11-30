require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'http://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.09.02'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.09.02.tar.gz'
  source_sha256 '9fffd8e8157ee969dfe99d1a5b310ff3337b1dbecd276ccaa8c30c1cc14392fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c125713560fc1b94cf7608fb4b5750579a5b204daf94a2a513225ce5c9c2fd51',
     armv7l: 'c125713560fc1b94cf7608fb4b5750579a5b204daf94a2a513225ce5c9c2fd51',
       i686: 'ae548b400f4130bfa2613bd76d64483ee6df9d63dd0ec66b3de43ae63029db44',
     x86_64: 'b1717d935512bca5caf350790b00d5a5f08fbfdec855a0221d95ea7f7879b383',
  })

  def self.build
    system 'make',
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man1",
      "JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs"
  end

  def self.install
    system 'make',
      "DESTDIR=#{CREW_DEST_DIR}",
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man1",
      "JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs",
      'install'
  end
end
