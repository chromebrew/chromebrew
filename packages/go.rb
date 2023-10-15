require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.21.3'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.21.3.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.21.3.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.21.3.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.21.3.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'a1ddcaaf0821a12a800884c14cb4268ce1c1f5a0301e9060646f1e15e611c6c7',
     armv7l: 'a1ddcaaf0821a12a800884c14cb4268ce1c1f5a0301e9060646f1e15e611c6c7',
       i686: 'fb209fd070db500a84291c5a95251cceeb1723e8f6142de9baca5af70a927c0e',
     x86_64: '1241381b2843fae5a9707eec1f8fb2ef94d827990582c7c7c32f5bdfbfd420c8'
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
