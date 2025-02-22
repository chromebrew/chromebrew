require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.22.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'c4b2852516cd66b29c83bdbe9647b5bee4ce90d74c3b472940f32a87b0cd5ddb',
     armv7l: 'c4b2852516cd66b29c83bdbe9647b5bee4ce90d74c3b472940f32a87b0cd5ddb',
       i686: '42e376f53cd817ff5bde48945feb22616301190e3862375614820ddb95affdb7',
     x86_64: '04b20aeeb5f495ddf806219797adb8e99418a9bbb4440c67b426680f82b7bd1b'
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
