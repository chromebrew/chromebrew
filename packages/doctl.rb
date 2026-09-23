require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.171.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20ed948520cfb5e2b7f5501f1d6b23ab67830a169f957a7012fce12994ca6dbd',
     armv7l: '20ed948520cfb5e2b7f5501f1d6b23ab67830a169f957a7012fce12994ca6dbd',
       i686: 'fea47a34c7bf147e8b3eb69301d731e880b6ecfcabe6ed208467b272e8e3ea15',
     x86_64: '1786d8caeef85de99d1f1e522f3a557b3a18082ecb46e3d65704ba1f929769c9'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
