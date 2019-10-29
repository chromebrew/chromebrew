require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '2.4.1.0'
  source_url 'https://www.haskell.org/cabal/release/cabal-install-2.4.1.0/cabal-install-2.4.1.0.tar.gz'
  source_sha256 '69bcb2b54a064982412e1587c3c5c1b4fada3344b41b568aab25730034cb21ad'
  
  depends_on 'ghc'

  def self.install
    system "install -Dm755 cabal #{CREW_DEST_PREFIX}/bin/cabal"
  end
end
