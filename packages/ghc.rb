require 'package'

class Ghc < Package
  description 'The Glasgow Haskell Compiler is a state-of-the-art, open source compiler and interactive environment for the functional language Haskell.'
  homepage 'https://www.haskell.org/ghc/'
  version '8.4.2'
  source_url 'https://www.haskell.org/ghc/download_ghc_8_4_2.html'
  source_sha256 'a0f4ee8bdd284d869a3db0a0c58f83800a880293ccc19abc5e9debd2e7ab93d7'

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
