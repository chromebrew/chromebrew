require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.22.3'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.22.3.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.22.3.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.22.3.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.22.3.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'f2bacad20cd2b96f23a86d4826525d42b229fd431cc6d0dec61ff3bc448ef46e',
     armv7l: 'f2bacad20cd2b96f23a86d4826525d42b229fd431cc6d0dec61ff3bc448ef46e',
       i686: 'fefba30bb0d3dd1909823ee38c9f1930c3dc5337a2ac4701c2277a329a386b57',
     x86_64: '8920ea521bad8f6b7bc377b4824982e011c19af27df88a815e3586ea895f1b36'
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
