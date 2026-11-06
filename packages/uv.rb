require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.13.7'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '5e2a1315a1b8b4a25250d536f62fa5c1ab5ed17233e7bf486c3c7849cb663284',
     armv7l: '5e2a1315a1b8b4a25250d536f62fa5c1ab5ed17233e7bf486c3c7849cb663284',
       i686: 'cc4f86390f9c99e8f53530e5e7f2cdc6ae7c011c9e805764332a3e3c01a378e4',
     x86_64: 'c5221ff41b7892bfc223543883600125f6a47fe845093e0f5bdff4f359196d83'
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
