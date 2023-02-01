require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.20'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.20.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.20.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.20.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.20.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'ee8550213c62812f90dbfd3d098195adedd450379fd4d3bb2c85607fd5a2d283',
     armv7l: 'ee8550213c62812f90dbfd3d098195adedd450379fd4d3bb2c85607fd5a2d283',
       i686: '1420582fb43a15dbe94760fdd92171315414c4afc21ffe9d3b5875f9386ebe53',
     x86_64: '5a9ebcc65c1cce56e0d2dc616aff4c4cedcfbda8cc6f0288cc08cda3b18dcbf1'
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
