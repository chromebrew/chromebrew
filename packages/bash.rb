require 'package'

class Bash < Package
  description 'The Bourne Again SHell'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1-rc2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1-rc2.tar.gz'
  source_sha256 'f3274290260e2c74a2ec61606cc932cc0e093028d55c779cf2c7907bdb60abc0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-rc2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-rc2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-rc2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-rc2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '562213c4787968ce3288bbf1d2386da08f4c91b0138a4f4837de5cfc7f10eabc',
     armv7l: '562213c4787968ce3288bbf1d2386da08f4c91b0138a4f4837de5cfc7f10eabc',
       i686: '534048335a150bec1db6c7c3a717b550bc3fd80c8693aa2eb5b30298d5df3a85',
     x86_64: '8637084b5d2d0d33c6f4df06f9fa99624f59de4f845ef4b1e68335790e881eb0',
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
     system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
     FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
  
  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Make newer version of bash startup automatically' >> ~/.bashrc".lightblue
    puts "echo '#{CREW_PREFIX}/bin/sh' >> ~/.bashrc".lightblue
    puts "echo \"PS1=$PS1\" >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
