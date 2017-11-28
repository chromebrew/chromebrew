require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'http://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.09.02'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.09.02.tar.gz'
  source_sha256 '9fffd8e8157ee969dfe99d1a5b310ff3337b1dbecd276ccaa8c30c1cc14392fd'

  binary_url ({
  })
  binary_sha256 ({
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
