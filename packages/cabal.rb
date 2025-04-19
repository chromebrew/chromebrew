require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.14.2.0'
  license 'BSD'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-alpine3_17.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-alpine3_12.tar.xz"
  })
  source_sha256({
    x86_64: 'f99df35fd67519888188b10689f999267e27beacb9fdd64c8a16073ca9d0a49c',
      i686: 'c3cddb81eca95dd6082844ede3f714134d828ac59102ce3c02b412ba000a462e'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end
end
