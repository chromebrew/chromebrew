require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.20.1'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.20.1.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.20.1.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.20.1.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.20.1.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'e4edc05558ab3657ba3dddb909209463cee38df9c1996893dd08cde274915003',
     armv7l: 'e4edc05558ab3657ba3dddb909209463cee38df9c1996893dd08cde274915003',
       i686: '3a7345036ebd92455b653e4b4f6aaf4f7e1f91f4ced33b23d7059159cec5f4d7',
     x86_64: '000a5b1fca4f75895f78befeb2eecf10bfff3c428597f3f1e69133b63b911b02'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
  end
end
