require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '2.4.1.0-1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://downloads.haskell.org/~cabal/cabal-install-2.4.1.0/cabal-install-2.4.1.0-i386-unknown-linux.tar.xz'
    source_sha256 'b2da736cc27609442b10f77fc1a687aba603a7a33045b722dbf1a0066fade198'
  when 'x86_64'
    source_url 'https://downloads.haskell.org/~cabal/cabal-install-2.4.1.0/cabal-install-2.4.1.0-x86_64-unknown-linux.tar.xz'
    source_sha256 '6136c189ffccaa39916f9cb5788f757166444a2d0c473b987856a79ecbf0c714'
  end

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'ghc'
  end

  def self.install
    system "install -Dm755 cabal #{CREW_DEST_PREFIX}/bin/cabal"
  end
end
