require 'package'

class Ghc < Package
  description 'The Glasgow Haskell Compiler is a state-of-the-art, open source compiler and interactive environment for the functional language Haskell.'
  homepage 'https://www.haskell.org/ghc/'
  version '8.6.5-1'
  compatibility 'all'
  source_url 'https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-src.tar.xz.sig'
  source_sha256 '0535eaee892010244bcb686b6ad45941da5b233e729669bef87ad667164ae4ed'

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
