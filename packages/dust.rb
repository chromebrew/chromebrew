require 'package'

class Dust < Package
  description 'A more intuitive version of du in rust'
  homepage 'https://github.com/bootandy/dust'
  version '1.2.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '6418bb07a767c3cc37cd5730c308e62f780d82a2adff3ec1f3469c5cf032b084',
     armv7l: '6418bb07a767c3cc37cd5730c308e62f780d82a2adff3ec1f3469c5cf032b084',
       i686: 'a8387c884b1a7785cc0c5ebe03407389e00a393c16b46e3fac860e9a70707d34',
     x86_64: '707cfdbfb9d2dc536f8c3853815bbe98a01012f2772463835edae06816551160'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'dust', "#{CREW_DEST_PREFIX}/bin/dust", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dust' to get started.\n"
  end
end
