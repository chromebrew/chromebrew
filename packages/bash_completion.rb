require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.8'
  source_url 'https://github.com/scop/bash-completion/archive/2.8.tar.gz'
  source_sha256 'c3f1bacac64bc69e3dfb9b1ef79ddbf755aac441b452845531950f1643bed25f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de8e10c9a5d3bf2be05d6fac39e10db2ab1d39c6c9d6b3f3acdec71b6d9f9f04',
     armv7l: 'de8e10c9a5d3bf2be05d6fac39e10db2ab1d39c6c9d6b3f3acdec71b6d9f9f04',
       i686: 'ee87f97c9a5ccec83d6f618fdc09c5af0ec93a095d717ff3fbc8b24137bf264a',
     x86_64: '9efbe3b29ab29977df9c6f1cce34fb06677590bd2a4c44ad6da5b3d49b5f7d9c',
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
