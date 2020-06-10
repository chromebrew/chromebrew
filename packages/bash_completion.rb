require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.9'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion/archive/2.9.tar.gz'
  source_sha256 'fddd9e6739c972eea95d1f0e0e84fa9a17a5935ba21eab37308b27580cc4d790'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bash_completion-2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '502492db2fbc07546e7f0972f01298e2ac7519ec6a511ffdb3475534fdd79ebf',
     armv7l: '502492db2fbc07546e7f0972f01298e2ac7519ec6a511ffdb3475534fdd79ebf',
       i686: 'e38797e5345dcd15c7d948c6dde71fff17f000934112776cccb87fa25ed46d1d',
     x86_64: '5d8a424a3ef39742f9448b4da8225fbc1e75d9198023697a8c970ea5b4d6d0ae',
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
