require 'package'

class Dust < Package
  description 'A more intuitive version of du in rust'
  homepage 'https://github.com/bootandy/dust'
  version '1.2.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'b8c0d1171838a24b6ee08143af6d8e6e442a5cac136b046bb92849a897864f8f',
     armv7l: 'b8c0d1171838a24b6ee08143af6d8e6e442a5cac136b046bb92849a897864f8f',
       i686: '364f0daa7558b69fa45f7503f636553617409c59cf9eb0686d0796ea6d54347e',
     x86_64: 'e727d3c1d7891038a14443657c09586fa33ad77757816709129b0b06cd165c02'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'dust', "#{CREW_DEST_PREFIX}/bin/dust", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dust' to get started.\n"
  end
end
