require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.12.1.0'
  license 'BSD'
  compatibility 'x86_64 i686'
  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-alpine3_12.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-alpine3_12.tar.xz"
  })
  source_sha256({
    x86_64: '6fa71b75c87cd57700348fc9c089703201aac5fd248a92e6bc7346fd2e007da7',
      i686: '7890041cba03195bac2835eecaec349c39aad2ec0b729bd0c92f6f7f7ea240bf'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end
end
