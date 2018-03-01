require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '2.0.0.1'
  case ARCH
  when 'i686'
    source_url 'https://www.haskell.org/cabal/release/cabal-install-2.0.0.1/cabal-install-2.0.0.1-i386-unknown-linux.tar.gz'
    source_sha256 '3198c04aeddc38847e4b25ad4590f17a9e5e41eba0b6f1c6fba997d7e73388d8'
  when 'x86_64'
    source_url 'https://www.haskell.org/cabal/release/cabal-install-2.0.0.1/cabal-install-2.0.0.1-x86_64-unknown-linux.tar.gz'
    source_sha256 '915f9bc9944a6854ed9255c2a38cb18366fa94e5c7f584ebf139e829bda98764'
  else
    puts "#{ARCH} architecture not supported.".lightred
  end

  depends_on 'ghc'

  def self.install
    system "install -Dm755 cabal #{CREW_DEST_PREFIX}/bin/cabal"
  end
end
