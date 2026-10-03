require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.51.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9cc44316f5ae0854f70848d232505723dcc721408b5404736333d84d36ec94d6',
     armv7l: '9cc44316f5ae0854f70848d232505723dcc721408b5404736333d84d36ec94d6',
       i686: '8b6d0e4be23e9810bd4cd8f20e248e3c997e10bb36039585d15be93252023956',
     x86_64: '3afcfaea2aa5e9bf3e95f93c6ad483f05cb3d8d3ec99a4f51f3a63994046f186'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
