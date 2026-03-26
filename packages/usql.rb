require 'package'

class Usql < Package
  description 'Universal command-line interface for SQL databases'
  homepage 'https://github.com/xo/usql'
  version '0.21.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '6b95a95c591f97a1f1e2b2507d2174bfe70fb43e6db2ce0cf1b26d145716ae04'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install -tags most github.com/xo/usql@v#{version}"
  end
end
