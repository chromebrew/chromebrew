require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'http://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.09.59'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.09.59.tar.xz'
  source_sha256 'c6fc82fa0f16fcdc90d1ea725af62f130d3fa8501b74800afec0432db81fae95'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.59-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.59-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.59-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stressng-0.09.59-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '862603399c797ab3387c325a2617676c2c66ba3f091fb716061cd987b5f75541',
     armv7l: '862603399c797ab3387c325a2617676c2c66ba3f091fb716061cd987b5f75541',
       i686: '800c4755a2cb5520c9063a8a76e942f225531f405ebe666eb54d82ecb10630a5',
     x86_64: '288685a161f8e69f70d6b320487ecea68d8093f44b7c4c5b22893242558ed9d9',
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
