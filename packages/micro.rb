require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '1.3.3'
  source_url 'https://github.com/zyedidia/micro/archive/v1.3.3.tar.gz'
  source_sha256 '22256792cd7136996f0b62f0ac789c1d86b4b96a01390058570b4b067592160b'

  binary_url ({
     armv7l: 'https://github.com/Alanaktion/chromebrew/releases/download/micro-v1.3.3/micro-1.3.3-arm.tar.xz',
    aarch64: 'https://github.com/Alanaktion/chromebrew/releases/download/micro-v1.3.3/micro-1.3.3-arm.tar.xz',
       i686: 'https://github.com/Alanaktion/chromebrew/releases/download/micro-v1.3.3/micro-1.3.3-i686.tar.xz',
     x86_64: 'https://github.com/Alanaktion/chromebrew/releases/download/micro-v1.3.3/micro-1.3.3-x86_64.tar.xz',
  })
  binary_sha256 ({
     armv7l: 'a33553178de468deee6922b6ddbedd2f7340eece225f143e0514838637220d0f',
    aarch64: 'a33553178de468deee6922b6ddbedd2f7340eece225f143e0514838637220d0f',
       i686: '90ee8680dbde1ef467f32a0c291fd244ada8dc6eb6ac89d8056a3617cfb93251',
     x86_64: '7cc32cbc7fccf0e8fd48a2ab38d9e32a0d645dfee69a329c802d1802253ddbab',
  })

  depends_on 'go' => :build

  def self.install
    system "go get -d github.com/zyedidia/micro/cmd/micro"
    gopath = `go env GOPATH`.strip
    Dir.chdir "#{gopath}/src/github.com/zyedidia/micro/cmd/micro" do
      system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
      system "go build -o #{CREW_DEST_DIR}/usr/local/bin/micro"
    end
  end
end
