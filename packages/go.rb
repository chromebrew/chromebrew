require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.25.7'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
     armv7l: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
       i686: "https://go.dev/dl/go#{version}.linux-386.tar.gz",
     x86_64: "https://go.dev/dl/go#{version}.linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '1ba07e0eb86b839e72467f4b5c7a5597d07f30bcf5563c951410454f7cda5266',
     armv7l: '1ba07e0eb86b839e72467f4b5c7a5597d07f30bcf5563c951410454f7cda5266',
       i686: '2866517e9ca81e6a2e85a930e9b11bc8a05cfeb2fc6dc6cb2765e7fb3c14b715',
     x86_64: '12e6d6a191091ae27dc31f6efc630e3a3b8ba409baf3573d955b196fdf086005'
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
