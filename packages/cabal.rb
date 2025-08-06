require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.16.0.0'
  license 'BSD'
  compatibility 'i686 x86_64'

  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-alpine3_12.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-alpine3_20.tar.xz"
  })
  source_sha256({
    x86_64: '47969e8da0d6714b74fe54acfcb858484303497ea5b9a8a232c8cfb7272451be',
      i686: '94dd9d2b2a9eb6fb580bd78f0dc1d9bb73986f58319cb88b24586c9bc0f9ae74'
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
