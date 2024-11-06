require 'package'

class Glow < Package
  description 'Glow is a terminal based markdown reader.'
  homepage 'https://charm.sh'
  version '1.4.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_armv7.tar.gz',
     armv7l: 'https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_armv7.tar.gz',
       i686: 'https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_i386.tar.gz',
     x86_64: 'https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '6e409c3f31a22fd4022e48852cb090d320f633fae5b3f49f54ea579d516853d7',
     armv7l: '6e409c3f31a22fd4022e48852cb090d320f633fae5b3f49f54ea579d516853d7',
       i686: '06c2c30c7d90b6befe26c6fcb1cd9daff0581383fea5665891e9fa46ebdd36f0',
     x86_64: 'ab7b4cf9ae6e20d6c898688c5f33876297f9ef04616cbceff8e0379df9d06321'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'glow', "#{CREW_DEST_PREFIX}/bin/glow", mode: 0o755
  end
end
