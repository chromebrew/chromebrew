require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.11.08'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.11.08.tar.xz'
  source_sha256 '07090ed5aef4e8d406f9c1927fc816db1068ab02d3aa53120481b14872a9c5f7'

  binary_url ({
  })
  binary_sha256 ({
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
