require 'package'

class Glow < Package
  description 'Glow is a terminal based markdown reader.'
  homepage 'https://github.com/charmbracelet/glow'
  version '2.1.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_arm.tar.gz",
     armv7l: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_arm.tar.gz",
       i686: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_i386.tar.gz",
     x86_64: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '108a4f0370c38965a4aaaadb498b4ba0d2dc2ebad31690e32cbbad87302ba03b',
     armv7l: '108a4f0370c38965a4aaaadb498b4ba0d2dc2ebad31690e32cbbad87302ba03b',
       i686: '755eb843a7d652bd24663cca07d3b73400cf8d919b93d3b6fc525dc8f3befcf9',
     x86_64: '6063d4f2af8a82a5f4bba0831e165de9381660aa8b41df4816d0106a265b07d5'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'glow', "#{CREW_DEST_PREFIX}/bin/glow", mode: 0o755
  end
end
