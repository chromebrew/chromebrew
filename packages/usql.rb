require 'package'

class Usql < Package
  description 'Universal command-line interface for SQL databases'
  homepage 'https://github.com/xo/usql'
  version '0.21.6'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '9f0c5346aba52541882b8c621952b60b9f7e0b79fab28d2d26b922ff3a4382f4'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install -tags most github.com/xo/usql@v#{version}"
  end
end
