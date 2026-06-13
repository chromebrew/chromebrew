require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.11.21'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '929440f991ccd8097e01be1ec831f673ac7bbf508e94819b4270f2873f69e658',
     armv7l: '929440f991ccd8097e01be1ec831f673ac7bbf508e94819b4270f2873f69e658',
       i686: '07125219898b1c8e71bc612d91b190927c6b192a7bce5dd029b1c9070e9b7049',
     x86_64: '8c88519b0ef0af9801fcdee419bbb12116bd9e6b18e162ae093c932d8b264050'
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
