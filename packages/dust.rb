require 'package'

class Dust < Package
  description 'A more intuitive version of du in rust'
  homepage 'https://github.com/bootandy/dust'
  version '1.2.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '1ffe45f79df92af43186591814d8e3169eb61b3c0aed163d2f47786111178fdf',
     armv7l: '1ffe45f79df92af43186591814d8e3169eb61b3c0aed163d2f47786111178fdf',
       i686: 'e7f99e414634c923e1f3f441ab257be4a9bb065839ea1fbfee17750da23dd670',
     x86_64: 'ec3bf712c660dcaa5578b996741f5cca36b30c021c1e4b49352b11137a95a96e'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'dust', "#{CREW_DEST_PREFIX}/bin/dust", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dust' to get started.\n"
  end
end
