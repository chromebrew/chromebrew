require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.19.4'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.19.4.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.19.4.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.19.4.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.19.4.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: '7a51dae4f3a52d2dfeaf59367cc0b8a296deddc87e95aa619bf87d24661d2370',
     armv7l: '7a51dae4f3a52d2dfeaf59367cc0b8a296deddc87e95aa619bf87d24661d2370',
       i686: 'e5f0b0551e120bf3d1246cb960ec58032d7ca69e1adcf0fdb91c07da620e0c61',
     x86_64: 'c9c08f783325c4cf840a94333159cc937f05f75d36a8b307951d5bd959cf2ab8'
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
