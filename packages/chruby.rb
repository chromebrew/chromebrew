require 'package'

class Chruby < Package
  description 'Changes the current Ruby'
  homepage 'https://github.com/postmodern/chruby'
  version '0.3.9'
  source_url 'https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz'
  source_sha256 '7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/chruby/chruby.sh ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/chruby/chruby.sh' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
