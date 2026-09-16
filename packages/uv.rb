require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.12.15'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'a0afe9cfc7dc4acc18e613f68c5b010b849323b3a3d6e9311b29d289dc94f95e',
     armv7l: 'a0afe9cfc7dc4acc18e613f68c5b010b849323b3a3d6e9311b29d289dc94f95e',
       i686: '6fa19118f01ee547d5b9a3f4af389c5c929a34e0074a4313d3cdb3ce9c97fdcd',
     x86_64: 'f97935763c04be3e692460a7aaeaaab8fc3b78fcf8b389da820b38ae7423a638'
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
