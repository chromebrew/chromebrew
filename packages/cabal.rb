require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.16.1.0'
  license 'BSD'
  compatibility 'i686 x86_64'

  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-alpine3_12.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-alpine3_22.tar.xz"
  })
  source_sha256({
    x86_64: '5ebe58932e7856dd08e5617414597c5d07799d72796faf24d23f2355ca37b3df',
      i686: 'ee40adbb1407b61e01624d09326783d12f7d67755511ae18b5df8e1dbb91d11b'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'cabal', "#{CREW_DEST_PREFIX}/bin/cabal", mode: 0o755
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/cabal")
  end
end
