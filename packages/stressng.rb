require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.11.22-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.11.22.tar.xz'
  source_sha256 '408153d64be1d8a8d584e5f48d9fd09602adf4095a17c0b542cb41e636cf0464'

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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # stressng bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/stress-ng
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/stressng", @env)
  end
end
