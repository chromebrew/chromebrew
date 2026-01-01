require 'package'

class Usql < Package
  description 'Universal command-line interface for SQL databases'
  homepage 'https://github.com/xo/usql'
  version '0.20.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'aebb1e0fb75dab1b1627c2e315b2b7810f7fac636efb4d2b7acb74252bd1a571'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install -tags most github.com/xo/usql@v#{version}"
  end
end
