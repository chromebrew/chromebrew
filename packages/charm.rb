require 'package'

class Charm < Package
  description 'Charm is a set of tools that makes adding a backend to your terminal-based applications fun and easy.'
  homepage 'https://charm.sh'
  version '0.12.6'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/charmbracelet/charm/releases/download/v#{version}/charm_#{version}_linux_arm.tar.gz",
     armv7l: "https://github.com/charmbracelet/charm/releases/download/v#{version}/charm_#{version}_linux_arm.tar.gz",
       i686: "https://github.com/charmbracelet/charm/releases/download/v#{version}/charm_#{version}_linux_i386.tar.gz",
     x86_64: "https://github.com/charmbracelet/charm/releases/download/v#{version}/charm_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'cf4db7bb9a891a83f7405a2b09af9f38bbb1383add44a54335629270b2659156',
     armv7l: 'cf4db7bb9a891a83f7405a2b09af9f38bbb1383add44a54335629270b2659156',
       i686: 'a3cd9a881994598f59f14b7fdadc54a175ac2b29752f86dc25178d99a285564c',
     x86_64: '3dc72e9e4ce9f0dfc771955d320cc26e52053f501ff128d0329f6ad4f3859ce9'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'charm', "#{CREW_DEST_PREFIX}/bin/charm", mode: 0o755
  end
end
