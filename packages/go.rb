require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.26.1'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
     armv7l: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
       i686: "https://go.dev/dl/go#{version}.linux-386.tar.gz",
     x86_64: "https://go.dev/dl/go#{version}.linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'c9937198994dc173b87630a94a0d323442bef81bf7589b1170d55a8ebf759bda',
     armv7l: 'c9937198994dc173b87630a94a0d323442bef81bf7589b1170d55a8ebf759bda',
       i686: 'da75d696c6b9440fe9fb6418429f29eaeee947707ee8c6ddb567c558051a1cc2',
     x86_64: '031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a'
  })

  conflicts_ok # FIXME: Remove this when file conflicts between go and gcc are fixed
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
