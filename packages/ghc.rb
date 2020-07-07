require 'package'

class Ghc < Package
  description 'The Glasgow Haskell Compiler is a state-of-the-art, open source compiler and interactive environment for the functional language Haskell.'
  homepage 'https://www.haskell.org/ghc/'
  version '8.8.3'
  compatibility 'all'
  source_url 'https://downloads.haskell.org/~ghc/8.8.3/ghc-8.8.3-src.tar.xz.sig'
  source_sha256 'fcdb99dabdf74c5a0607df5276df2cd12b8b7bedcac4079546bb9418c8438f02'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'stack'
  depends_on 'libtinfo'

  def self.build
    system "stack setup ghc-#{version}"
    system "echo '#!/bin/bash' > ghc"
    system "echo 'stack exec -- ghc \"\$@\"' >> ghc"
  end

  def self.install
    system "install -Dm755 ghc #{CREW_DEST_PREFIX}/bin/ghc"
  end
end
