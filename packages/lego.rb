require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.23.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '56d3c2e3f85467203d359bbc0d15ff3431a205012bd827ace238e2b541311ed5',
     armv7l: '56d3c2e3f85467203d359bbc0d15ff3431a205012bd827ace238e2b541311ed5',
       i686: '6c99379a93008adc85c4531af84d43dc5fff2bc124cdbbaf21b805fb9e4ed0a3',
     x86_64: '1fd60b1fd59c239bed22719a5de402cb745d1f933540cb1ec196e2c03e6e8882'
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
