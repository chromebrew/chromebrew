require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.12.22'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'ec4d636bce8cc4d2ff0a927f2805671e2d7377e3f3f7b42109d5d4633839fa41',
     armv7l: 'ec4d636bce8cc4d2ff0a927f2805671e2d7377e3f3f7b42109d5d4633839fa41',
       i686: '221bbc2362b7cbf651e3fbb0a228c034820bb07f9efe2785c9339828fcdf079b',
     x86_64: 'b9980552309f09c15172b8be828555e375097f16deb459795ce7bfd200380f0b'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install %w[uv uvx], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'uv -h' to get started.\n"
  end
end
