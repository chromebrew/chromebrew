require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.14.1.0'
  license 'BSD'
  compatibility 'x86_64 i686'
  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-alpine3_12.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-alpine3_12.tar.xz"
  })
  source_sha256({
    x86_64: 'b314d017d7525b662d9571b0de15870882862e32948d4c5d78e209641b474279',
      i686: 'aeff8b622c18a8dc2cb6adc5b7e90fd807a92b51a9f689fc5804c2b91675b1b8'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end
end
