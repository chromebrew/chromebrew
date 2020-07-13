require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.11.08'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.11.08.tar.xz'
  source_sha256 '07090ed5aef4e8d406f9c1927fc816db1068ab02d3aa53120481b14872a9c5f7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4c3489fafb782bb165e2b2c776c44d1f31a8971293f0db661d2968b157f99326',
     armv7l: '4c3489fafb782bb165e2b2c776c44d1f31a8971293f0db661d2968b157f99326',
       i686: '4878e3a8ba6f1a73f1d65d9d297d01d52bd8bbe3d561619bc79144c2959591b4',
     x86_64: '83717195b9dd2795ffbda928870e333b609fc16eab63a3980fefb5b69a186584',
  })

  def self.build
    system 'make',
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man1",
      "JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs",
      "BASHDIR=#{CREW_PREFIX}/share/bash-completion/completions"
  end

  def self.install
    system 'make',
      "DESTDIR=#{CREW_DEST_DIR}",
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man1",
      "JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs",
      "BASHDIR=#{CREW_PREFIX}/share/bash-completion/completions",
      'install'
  end

  def self.postinstall
    puts
    puts "To add bash completion, execute the following:".lightblue
    puts "echo 'source #{CREW_PREFIX}/share/bash-completion/completions/stress-ng' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
