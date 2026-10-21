require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.27.3'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
     armv7l: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
       i686: "https://go.dev/dl/go#{version}.linux-386.tar.gz",
     x86_64: "https://go.dev/dl/go#{version}.linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'd6f4e11dd7157030d7ac11c51c8f73201a2db932d593c3106b1da11cc32bfdf8',
     armv7l: 'd6f4e11dd7157030d7ac11c51c8f73201a2db932d593c3106b1da11cc32bfdf8',
       i686: 'cfc243057c03dd131413b91269d16b5061f87f312059c1ed78681cbb95d6afbf',
     x86_64: '65efbc80fdc1fa2cd2631cad5b481777a68e8725f34e89f50fc6ac714e379b40'
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
