require 'package'

class Usql < Package
  description 'Universal command-line interface for SQL databases'
  homepage 'https://github.com/xo/usql'
  version '0.21.4'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '724b9218da79ef04d0973e7605ad1c6502667f8f19818dd280b5d39c8e520c1e'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install -tags most github.com/xo/usql@v#{version}"
  end
end
