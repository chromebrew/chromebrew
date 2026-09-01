require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.168.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed595c8118c4a20003d684d1c78965d81a77875f934cd38141bb0d4ff97f27e8',
     armv7l: 'ed595c8118c4a20003d684d1c78965d81a77875f934cd38141bb0d4ff97f27e8',
       i686: '2b7a885d603955db25b8252f90f72630bb221621512d24e74f490fee06fa54fe',
     x86_64: 'edb11f0206042ccdea13bef8bbc0d138c90d1841a1222a535ce5db2eb1caf7bd'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
