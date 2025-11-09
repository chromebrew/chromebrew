require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.28.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'a3d6bfbb9a2e477b0ed0dbfd260052ed941a613bc4dd2a70301281f4fc6bda81',
     armv7l: 'a3d6bfbb9a2e477b0ed0dbfd260052ed941a613bc4dd2a70301281f4fc6bda81',
       i686: '8e23581a5e17dad9adc96e9f7974227b543f99ef772b9e4fca7735559659dc77',
     x86_64: '592f26b00837fbc3f05698761130ced2468eac0de924e9e3d5d55bd5560e4b6b'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'lego', "#{CREW_DEST_PREFIX}/bin/lego", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'lego' to get started.\n"
  end
end
