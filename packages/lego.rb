require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.14.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/go-acme/lego/releases/download/v4.14.0/lego_v4.14.0_linux_armv7.tar.gz',
     armv7l: 'https://github.com/go-acme/lego/releases/download/v4.14.0/lego_v4.14.0_linux_armv7.tar.gz',
       i686: 'https://github.com/go-acme/lego/releases/download/v4.14.0/lego_v4.14.0_linux_386.tar.gz',
     x86_64: 'https://github.com/go-acme/lego/releases/download/v4.14.0/lego_v4.14.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '4c3494b4fb1df16d9e51d954a48a23416fb17c4aad033af7ab2f9cd1a7f31693',
     armv7l: '4c3494b4fb1df16d9e51d954a48a23416fb17c4aad033af7ab2f9cd1a7f31693',
       i686: 'ed1377f2e4a094ad6221349401bfe7d8bc52baff40cfcfd4a617db6830297069',
     x86_64: '6ac2bbfc67069a62407389c1ac36590ca70d7adf1f940c4288c11b2d0b628dd7'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'lego', "#{CREW_DEST_PREFIX}/bin/lego", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'lego' to get started.\n".lightblue
  end
end
