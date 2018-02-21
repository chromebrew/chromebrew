require 'package'

class Ghc < Package
  description 'The Glasgow Haskell Compiler is a state-of-the-art, open source compiler and interactive environment for the functional language Haskell.'
  homepage 'https://www.haskell.org/ghc/'
  version '8.2.2'
  source_url 'https://www.haskell.org/ghc/download_ghc_8_2_2.html'
  source_sha256 'faceb0629054cc52ba70abad9179564df8dcbc0f9349df85698966047c274f7a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'stack'
  depends_on 'libtinfo'

  def self.build
    system "stack setup ghc-8.2.2"
    system "echo '#!/bin/bash' > ghc"
    system "echo 'stack ghc \"\$@\"' >> ghc"
  end

  def self.install
    system "install -Dm755 ghc #{CREW_DEST_PREFIX}/bin/ghc"
  end
end
