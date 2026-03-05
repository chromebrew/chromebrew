require 'package'

class Usql < Package
  description 'Universal command-line interface for SQL databases'
  homepage 'https://github.com/xo/usql'
  version '0.21.1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '9303852f01d49bc5d412d7ebc0af65b5a707bc1769e3a45b88c11f393c53afc3'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install -tags most github.com/xo/usql@v#{version}"
  end
end
