require 'package'

class Commacd < Package
  description 'A faster way to move around (Bash 3+)'
  homepage 'https://github.com/shyiko/commacd'
  version '0.3.4'
  source_url 'https://github.com/shyiko/commacd/archive/v0.3.4.tar.gz'
  source_sha256 'e27401c5455eb0b89f8e5a3c1e69165d3b73c90a4cb37f439ed27bf120411de0'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm644 commacd.bash #{CREW_DEST_PREFIX}/share/commacd/commacd.bash"
  end

  def self.postinstall
    puts
    puts "To complete installation, execute the following:".lightblue
    puts "echo '# commacd completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/commacd/commacd.bash ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/commacd/commacd.bash' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
