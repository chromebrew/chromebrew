require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://go.dev'
  version '1.24.4'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
     armv7l: "https://go.dev/dl/go#{version}.linux-armv6l.tar.gz",
       i686: "https://go.dev/dl/go#{version}.linux-386.tar.gz",
     x86_64: "https://go.dev/dl/go#{version}.linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '718e37a71bb835d07dbd7611c244c40260b3aac9d8cd6d63ee369df1e359547e',
     armv7l: '718e37a71bb835d07dbd7611c244c40260b3aac9d8cd6d63ee369df1e359547e',
       i686: '21fe8e7fb4bd2fe82c49e034602483583688f011bcfe76b6be23be36fa90fcaa',
     x86_64: '4b6e1c0acc6398cd0e66907df5f0245f77e39ca120b375e89c6ce36bf6ec2bfc'
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
