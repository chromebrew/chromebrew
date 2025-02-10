require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.14.1.1'
  license 'BSD'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-alpine3_12.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-alpine3_12.tar.xz"
  })
  source_sha256({
    x86_64: '9d5b8d386c94dcbd1fbf67f9bc355dcb0bcd4241031d26bdf46c05236bd9a917',
      i686: '8bc6ddb2c95a5d7d11dbc8c225fe5b4e77a4f244d7a1ca7912fbb19f2b57fc19'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end
end
