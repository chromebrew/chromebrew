require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.161.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50eb15f3299dad346b1e70d3829b21fc8562d5cccafb3359df16445d5ed55254',
     armv7l: '50eb15f3299dad346b1e70d3829b21fc8562d5cccafb3359df16445d5ed55254',
       i686: '21a136a905e67b1fe4325d4e3d6d134dd943e693a3c214e450df05a5a13aab17',
     x86_64: '57f9960ff46375b7bd01ab910c61a1bbd4ae7c53bb498d1e238adeebe6dcb290'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
