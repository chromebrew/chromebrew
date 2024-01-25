require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.21.5'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.21.5.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.21.5.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.21.5.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.21.5.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: '837f4bf4e22fcdf920ffeaa4abf3d02d1314e03725431065f4d44c46a01b42fe',
     armv7l: '837f4bf4e22fcdf920ffeaa4abf3d02d1314e03725431065f4d44c46a01b42fe',
       i686: '8f4dba9cf5c61757bbd7e9ebdb93b6a30a1b03f4a636a1ba0cc2f27b907ab8e1',
     x86_64: 'e2bc0b3e4b64111ec117295c088bde5f00eeed1567999ff77bc859d7df70078e'
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
