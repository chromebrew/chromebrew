require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.10.3.0'
  license 'BSD'
  compatibility 'x86_64 i686'
  source_url({
    x86_64: 'https://downloads.haskell.org/~cabal/cabal-install-3.10.3.0/cabal-install-3.10.3.0-x86_64-linux-alpine3_12.tar.xz',
      i686: 'https://downloads.haskell.org/~cabal/cabal-install-3.10.3.0/cabal-install-3.10.3.0-i386-linux-alpine3_12.tar.xz'
  })
  source_sha256({
    x86_64: '284978da43d9d52af678e52cbae8fb3359ec59180130b099913f5d3e6f19fda4',
      i686: '284978da43d9d52af678e52cbae8fb3359ec59180130b099913f5d3e6f19fda4'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end
end
