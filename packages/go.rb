require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.21.0'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.21.0.linux-arm64.tar.gz',
     armv7l: 'https://go.dev/dl/go1.21.0.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.21.0.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.21.0.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'f3d4548edf9b22f26bbd49720350bbfe59d75b7090a1a2bff1afad8214febaf3',
     armv7l: 'e377a0004957c8c560a3ff99601bce612330a3d95ba3b0a2ae144165fc87deb1',
       i686: '0e6f378d9b072fab0a3d9ff4d5e990d98487d47252dba8160015a61e6bd0bcba',
     x86_64: 'd0398903a16ba2232b389fb31032ddf57cac34efda306a0eebac34f0965a0742'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
  end
end
