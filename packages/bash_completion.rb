require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.8'
  source_url 'https://github.com/scop/bash-completion/archive/2.8.tar.gz'
  source_sha256 'c3f1bacac64bc69e3dfb9b1ef79ddbf755aac441b452845531950f1643bed25f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'autoconf'
  depends_on 'automake'

  def self.build
    system "autoreconf -i"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To complete installation, execute the following:".lightblue
    puts "echo '# bash completion' >> ~/.bashrc".lightblue
    puts "echo '[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]] && \\' >> ~/.bashrc".lightblue
    puts "echo '    . /usr/local/share/bash-completion/bash_completion' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end

end
