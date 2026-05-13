require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.0.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '38cd3bfa2669402004e1a96b0997e5b3e52b76f871cf0155b62caf0d72eedfd2',
     armv7l: '38cd3bfa2669402004e1a96b0997e5b3e52b76f871cf0155b62caf0d72eedfd2',
       i686: 'b12f2a06a775897aaac21cfde7c4e7a50cc265cd46418237e2ee7620a1f5de7a',
     x86_64: 'd82ab18985ad21a1a1f53c21e9470100b5171acf86751d0857ed2b9087aa3a42'
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
