require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.175.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1ffa21ff2475148f8c4e83f876aa66b17910167e2ee461ae8229e56ea72308c',
     armv7l: 'd1ffa21ff2475148f8c4e83f876aa66b17910167e2ee461ae8229e56ea72308c',
       i686: 'f142c5ff312a9e3ad0635b1c2d9eefdf4760d1d39a0362754a7422b2c23529f5',
     x86_64: 'f90354e0dba208b43642dc92d36ac8dbc95eca4a408b68f02591881fdf05d655'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
