require 'package'

class Glow < Package
  description 'Glow is a terminal based markdown reader.'
  homepage 'https://github.com/charmbracelet/glow'
  version '3.0.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_arm.tar.gz",
     armv7l: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_arm.tar.gz",
       i686: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_i386.tar.gz",
     x86_64: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'cb2aac35ae6c1e9656e38c5339ae30a826334e4d46511077c49f9699bd99c33d',
     armv7l: 'cb2aac35ae6c1e9656e38c5339ae30a826334e4d46511077c49f9699bd99c33d',
       i686: '9c304ad49cf0271e49d6f0a2c32df4b0a09941df4721f11795f82a7ef5df1ddf',
     x86_64: '13e05e4b2acc18d2aee44291aefe6325b077ec321b631a0cfa780e8e3bc33f78'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'glow', "#{CREW_DEST_PREFIX}/bin/glow", mode: 0o755
  end
end
