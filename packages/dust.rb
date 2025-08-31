require 'package'

class Dust < Package
  description 'A more intuitive version of du in rust'
  homepage 'https://github.com/bootandy/dust'
  version '1.2.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/bootandy/dust/releases/download/v#{version}/dust-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'df8f5cc6d6c4cdcef8598c700b7f3aa6a211e1c106f09cbae88d7336fb9fa544',
     armv7l: 'df8f5cc6d6c4cdcef8598c700b7f3aa6a211e1c106f09cbae88d7336fb9fa544',
       i686: '6f8e930f6d2be139dc80b49aba5d32dd18b8327508adf662caa456fb8b1e21b0',
     x86_64: 'f6a590a958a7fd1529fea7ae99b36be10158aa3a0ec0d686d83cc0ee89e9a142'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'dust', "#{CREW_DEST_PREFIX}/bin/dust", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'dust' to get started.\n"
  end
end
