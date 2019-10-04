require 'package'

class Ghc < Package
  description 'The Glasgow Haskell Compiler is a state-of-the-art, open source compiler and interactive environment for the functional language Haskell.'
  homepage 'https://www.haskell.org/ghc/'
  version '8.4.2'
  source_url 'https://downloads.haskell.org/~ghc/8.4.2/ghc-8.4.2-src.tar.xz.sig'
  source_sha256 '59d3aed5e4fee30e01b6710d57592f16f4f75ce67de97877ddaaa3cec9c6e348'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'stack'
  depends_on 'libtinfo'

  def self.build
    system "stack setup ghc-8.4.2"
    system "echo '#!/bin/bash' > ghc"
    system "echo 'stack ghc \"\$@\"' >> ghc"
  end

  def self.install
    system "install -Dm755 ghc #{CREW_DEST_PREFIX}/bin/ghc"
  end
end
