require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.22.5'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
     armv7l: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
       i686: "https://go.dev/dl/go#{version}.linux-386.tar.gz",
     x86_64: "https://go.dev/dl/go#{version}.linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '8c4587cf3e63c9aefbcafa92818c4d9d51683af93ea687bf6c7508d6fa36f85e',
     armv7l: '8c4587cf3e63c9aefbcafa92818c4d9d51683af93ea687bf6c7508d6fa36f85e',
       i686: '3ea4c78e6fa52978ae1ed2e5927ad17495da440c9fae7787b1ebc1d0572f7f43',
     x86_64: '904b924d435eaea086515bc63235b192ea441bd8c9b198c507e85009e6e4c7f0'
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
