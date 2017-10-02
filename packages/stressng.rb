require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'http://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.08.16'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.08.16.tar.gz'
  source_sha256 '315311d4fd09d1e06935bcb9c72b8bbb8289f8d4385a32a6b427bd067d816a87'

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
