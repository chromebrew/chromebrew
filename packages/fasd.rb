require 'package'

class Fasd < Package
  description 'Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v.'
  homepage 'https://github.com/clvv/fasd'
  version '1.0.1'
  compatibility 'all'
  source_url 'https://github.com/clvv/fasd/archive/1.0.1.tar.gz'
  source_sha256 '88efdfbbed8df408699a14fa6c567450bf86480f5ff3dde42d0b3e1dee731f65'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fasd-1.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fasd-1.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fasd-1.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fasd-1.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7e12326537a96166d6897f6419a15bdf0a3f9d2edf448dccdc484c7a7331433d',
     armv7l: '7e12326537a96166d6897f6419a15bdf0a3f9d2edf448dccdc484c7a7331433d',
       i686: 'e660e0968145d2b981d8d7f89c1f368912313c370cf5b92d15cea59b2b82b39f',
     x86_64: '860de1d2b40e13d439086a40f273e5dbf48e913c224e7e7274bca4625eaaffaa',
  })

  def self.install
    system "sed -i 's,share/man,man,' Makefile"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    puts ""
    puts "To get fasd working in a shell, some initialization code must be run:".lightblue
    puts "echo 'eval \"\$(fasd --init auto)\"' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts ""
  end
end
