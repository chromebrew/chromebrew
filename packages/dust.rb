require 'package'

class Dust < Package
  description 'A more intuitive version of du in rust'
  homepage 'https://github.com/bootandy/dust'
  version '1.2.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'e714a1cbd5a375489d06653256cd39b5144351fee0a21b00a694fc70d2f1c892',
     armv7l: 'e714a1cbd5a375489d06653256cd39b5144351fee0a21b00a694fc70d2f1c892',
       i686: 'a9b4a80e5e12b3879f7556b4cf96c41ec54594668d5c48dcb56a70fbb68bc32d',
     x86_64: '64b16f5c10cc4c25d2eaa144e9d2d44b3ed8f72ee63b3bc0a92c85e21e9e0932'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'dust', "#{CREW_DEST_PREFIX}/bin/dust", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dust' to get started.\n"
  end
end
