require 'package'

class Bash < Package
  description 'The Bourne Again SHell'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1-rc2'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1-rc2.tar.gz'
  source_sha256 'f3274290260e2c74a2ec61606cc932cc0e093028d55c779cf2c7907bdb60abc0'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
     system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
     FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
  
  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Make newer version of bash startup automatically' >> ~/.bashrc".lightblue
    puts "echo '#{CREW_PREFIX}/bin/sh' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
  end
end
