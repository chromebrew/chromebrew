require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.7-1'
  source_url 'https://github.com/scop/bash-completion/archive/2.7.tar.gz'
  source_sha256 'dba2b88c363178622b61258f35d82df64dc8d279359f599e3b93eac0375a416c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '486ae7b4f7a8748dbb624eb0a83d7c54dcff3f95151fb202cb905e24b1c4546d',
     armv7l: '486ae7b4f7a8748dbb624eb0a83d7c54dcff3f95151fb202cb905e24b1c4546d',
       i686: 'dc0d6a60d98556ab3baa967a06058daa6199d26b1667c07f39c6ae6263ce8602',
     x86_64: '7e9cfea615bab8620a01384ee1e96c17218efa00bea1b7415c7680107a58cac2',
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
