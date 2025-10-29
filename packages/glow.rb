require 'package'

class Glow < Package
  description 'Glow is a terminal based markdown reader.'
  homepage 'https://github.com/charmbracelet/glow'
  version '2.1.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_arm.tar.gz",
     armv7l: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_arm.tar.gz",
       i686: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_i386.tar.gz",
     x86_64: "https://github.com/charmbracelet/glow/releases/download/v#{version}/glow_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'cf084110801d6949da9eeed5abf22d427d869a5e678acd7151aee9f9e85df4e8',
     armv7l: 'cf084110801d6949da9eeed5abf22d427d869a5e678acd7151aee9f9e85df4e8',
       i686: 'c248c4eec06496f60c4a534f802c4b38720a2f891d35698daa8d933ff4862895',
     x86_64: '59106b08be69b2a0bda1178327bbb7accd584e7c113ba3d2f5ef6e48ff3ac27f'
  })

  def self.install
    FileUtils.install 'glow', "#{CREW_DEST_PREFIX}/bin/glow", mode: 0o755
  end
end
