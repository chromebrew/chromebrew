require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '2.2.0.0'
  case ARCH
  when 'i686'
    source_url 'https://www.haskell.org/cabal/release/cabal-install-2.2.0.0/cabal-install-2.2.0.0-i386-unknown-linux.tar.gz'
    source_sha256 '20cc07bc7c813fac3e88bb308c972e3a28ade30dd32783d7a74cdadc74c5079e'
  when 'x86_64'
    source_url 'https://www.haskell.org/cabal/release/cabal-install-2.2.0.0/cabal-install-2.2.0.0-x86_64-unknown-linux.tar.gz'
    source_sha256 '35c14663496cd18bf33cdcf4441a77eb169b0a93cfd0b79081c6816ada53f05c'
  end

  depends_on 'ghc'

  def self.install
    system "install -Dm755 cabal #{CREW_DEST_PREFIX}/bin/cabal"
  end
end
