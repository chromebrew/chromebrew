require 'package'

class Cabal < Package
  description 'Common Architecture for Building Applications and Libraries'
  homepage 'https://www.haskell.org/cabal/'
  version '3.18.1.0'
  license 'BSD'
  compatibility 'i686 x86_64'

  source_url({
    x86_64: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-x86_64-linux-unknown.tar.xz",
      i686: "https://downloads.haskell.org/~cabal/cabal-install-#{version}/cabal-install-#{version}-i386-linux-unknown.tar.xz"
  })
  source_sha256({
    x86_64: 'c6385c155ff61f792dfed0e8c101004db63f8d8b556dd6c9838f81a012bf28a6',
      i686: '8cf20d0d9b258c9add7efd0471da97b0c719c06422219e9211f5b16ca509c39e'
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
