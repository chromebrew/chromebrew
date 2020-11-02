require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.11.22'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.11.22.tar.xz'
  source_sha256 '408153d64be1d8a8d584e5f48d9fd09602adf4095a17c0b542cb41e636cf0464'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.11.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0720d4a1d77eec74276340abc0744905cc8c134224b7dfff4312a365d18d92a4',
     armv7l: '0720d4a1d77eec74276340abc0744905cc8c134224b7dfff4312a365d18d92a4',
       i686: '259742d2a4f8c170a922617eef24c03018a4bdd2132ac20693331de13c4a8ba9',
     x86_64: '996e29261b54bebc9bc63efe5df4f00dba7b86a29e4653fcdfa4a220aaf270d2',
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
