require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.11.29'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '7b5717ae304fbb1e94104699fb8c08b32d1537fedc90dd8fcf87768d818951ed',
     armv7l: '7b5717ae304fbb1e94104699fb8c08b32d1537fedc90dd8fcf87768d818951ed',
       i686: 'c62af324951ae6f31f9453280e077176c96b6e31897d8133c00411a91a20878f',
     x86_64: '04f8b82f5d47f0512dcd32c67a4a6f16a0ea27c81537c338fd0ad6b23cebe829'
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
