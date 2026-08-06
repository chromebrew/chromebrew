require 'package'

class Uv < Package
  description 'An extremely fast Python package and project manager, written in Rust.'
  homepage 'https://docs.astral.sh/uv/'
  version '0.12.2'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://releases.astral.sh/github/uv/releases/download/#{version}/uv-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '0536e78e9796394fa135102c7500f24a291aaf9fbf129b70add472b6dcf42a4b',
     armv7l: '0536e78e9796394fa135102c7500f24a291aaf9fbf129b70add472b6dcf42a4b',
       i686: '659b83b91a329a6bf5fbb412ea61262640b9bf15f07b6208334bd7a379c0dbf0',
     x86_64: 'd66e96b5f1ca3b99806eee283a8125d33a0bd669e6e6d9bc4ab7ffda63c41bf4'
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
