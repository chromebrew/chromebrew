require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.22.4'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.22.4.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.22.4.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.22.4.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.22.4.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'e2b143fbacbc9cbd448e9ef41ac3981f0488ce849af1cf37e2341d09670661de',
     armv7l: 'e2b143fbacbc9cbd448e9ef41ac3981f0488ce849af1cf37e2341d09670661de',
       i686: '47a2a8d249a91eb8605c33bceec63aedda0441a43eac47b4721e3975ff916cec',
     x86_64: 'ba79d4526102575196273416239cca418a651e049c2b099f3159db85e7bade7d'
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
