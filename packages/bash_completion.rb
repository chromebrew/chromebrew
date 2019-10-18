require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.9'
  source_url 'https://github.com/scop/bash-completion/archive/2.9.tar.gz'
  source_sha256 'fddd9e6739c972eea95d1f0e0e84fa9a17a5935ba21eab37308b27580cc4d790'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'autoreconf -i'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To complete installation, execute the following:".lightblue
    puts "echo '# bash completion' >> ~/.bashrc".lightblue
    puts "echo '[[ $PS1 && -f #{CREW_PREFIX}/share/bash-completion/bash_completion ]] && \\' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/bash_completion' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
