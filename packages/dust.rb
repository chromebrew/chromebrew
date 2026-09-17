require 'package'

class Dust < Package
  description 'A more intuitive version of du in rust'
  homepage 'https://github.com/bootandy/dust'
  version '1.2.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'd78cc3aade9bde5d7eaf724a2f0d3f09d484e92f87c29c64c17d5c9e021281b8',
     armv7l: 'd78cc3aade9bde5d7eaf724a2f0d3f09d484e92f87c29c64c17d5c9e021281b8',
       i686: '0657c64d00d8e9b05a46c003a9e95e4af4c0038d125ea6b5879f187b487ad204',
     x86_64: '14f788707aad217667f6812cf1a9639bf5c861a2ee815d486cffc36051f5e759'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'dust', "#{CREW_DEST_PREFIX}/bin/dust", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dust' to get started.\n"
  end
end
