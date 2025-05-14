require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.24.3'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
     armv7l: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
       i686: "https://go.dev/dl/go#{version}.linux-386.tar.gz",
     x86_64: "https://go.dev/dl/go#{version}.linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '17a392d7e826625dd12a32099df0b00b85c32d8132ed86fe917183ee5c3f88ed',
     armv7l: '17a392d7e826625dd12a32099df0b00b85c32d8132ed86fe917183ee5c3f88ed',
       i686: '41b1051063e68cbd2b919bf12326764fe33937cf1d32b5c529dd1a4f43dce578',
     x86_64: '3333f6ea53afa971e9078895eaa4ac7204a8c6b5c68c10e6bc9a33e8e391bdd8'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
  end
end
