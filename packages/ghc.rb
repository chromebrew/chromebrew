require 'package'

class Ghc < Package
  description 'The Glasgow Haskell Compiler is a state-of-the-art, open source compiler and interactive environment for the functional language Haskell.'
  homepage 'https://www.haskell.org/ghc/'
  version '9.0.2'
  license 'BSD'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed

  depends_on 'stack'

  def self.build
    system "stack setup ghc-#{version}"
    File.write 'ghc', <<~EOF
      #!/bin/bash
      stack exec -- ghc "$@"
    EOF
  end

  def self.install
    FileUtils.install 'ghc', "#{CREW_DEST_PREFIX}/bin/ghc", mode: 0o755
  end
end
