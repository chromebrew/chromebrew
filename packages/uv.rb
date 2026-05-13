require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.11.14'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '2aca3925d7ad91d2e02a0f9cf75974ebd077ec5cb939a5eb66aba096d5666819',
     armv7l: '2aca3925d7ad91d2e02a0f9cf75974ebd077ec5cb939a5eb66aba096d5666819',
       i686: '8c93880c54dc7a632f602b7627d4338d80011ecf32e340fd2f67129df5325dc7',
     x86_64: 'f3b623eb0e6141a7053d571d59a0bdc341e0f238ea8f5f0b4815ddbec9a2a296'
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
