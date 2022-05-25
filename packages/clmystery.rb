require 'package'

class Clmystery < Package
  description 'A command-line murder mystery'
  homepage 'https://github.com/veltman/clmystery'
  version '6dd30f'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/veltman/clmystery/archive/6dd30f8762c9319a3613eadd05fdf783baa4d7d9.tar.gz'
  source_sha256 '911bc77225bcacc8fc1a7b17b21fbc4ede371513c729b4b663989ab627604d33'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clmystery/6dd30f_armv7l/clmystery-6dd30f-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clmystery/6dd30f_armv7l/clmystery-6dd30f-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clmystery/6dd30f_i686/clmystery-6dd30f-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clmystery/6dd30f_x86_64/clmystery-6dd30f-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f7384340f728ba38105163d317cd827d079dbbddff846a0101127b90ecfc701c',
     armv7l: 'f7384340f728ba38105163d317cd827d079dbbddff846a0101127b90ecfc701c',
       i686: '9e440af530929d9afc4d9b02f6fda3cae503b029a830ed48341bc04ae76134b1',
     x86_64: '94797d72a05da4875e8d258cf36c88ce6a1f6943eb371c900fcc55e512c75102'
  })

  def self.install
    system 'mkdir $HOME/clmystery'
    system "mkdir -p #{CREW_DEST_DIR}/$HOME/clmystery"
    system 'cp -r . $HOME/clmystery'
    system "cp -r . #{CREW_DEST_DIR}/$HOME/clmystery"
  end

  def self.postinstall
    puts
    puts 'Learn command line basics by solving a murder mystery.'.lightblue
    puts
    puts 'To start, execute the following:'.lightblue
    puts 'cd ~/clmystery'.lightblue
    puts 'cat instructions'.lightblue
    puts
  end
end
