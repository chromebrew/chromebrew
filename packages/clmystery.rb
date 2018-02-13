require 'package'

class Clmystery < Package
  description 'A command-line murder mystery'
  homepage 'https://github.com/veltman/clmystery'
  version '6dd30f'
  source_url 'https://github.com/veltman/clmystery/archive/6dd30f8762c9319a3613eadd05fdf783baa4d7d9.tar.gz'
  source_sha256 '911bc77225bcacc8fc1a7b17b21fbc4ede371513c729b4b663989ab627604d33'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "mkdir $HOME/clmystery"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME/clmystery"
    system "cp -r . $HOME/clmystery"
    system "cp -r . #{CREW_DEST_DIR}/$HOME/clmystery"
  end

  def self.postinstall
    puts
    puts "Learn command line basics by solving a murder mystery.".lightblue
    puts
    puts "To start, execute the following:".lightblue
    puts "cd ~/clmystery".lightblue
    puts "cat instructions".lightblue
    puts
  end
end
