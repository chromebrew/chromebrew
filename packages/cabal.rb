require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.18.2.0'
  license 'BSD'
  compatibility 'i686 x86_64'

  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-unknown.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-unknown.tar.xz"
  })
  source_sha256({
    x86_64: 'b4f4c83135da77cfc18ccd6056398ca714a2dad86d5f635621ffdda8f9afe587',
      i686: '77bf3bc35c4748f5e9ab616c8ea483d079ca72838978d7d5819d07ecad92200a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/cabal")
  end
end
