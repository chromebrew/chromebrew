require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.178.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b552557fd65d35ba3c4e109a63ae1c6dca846814d64a9ba4b967949d99b97c0',
     armv7l: '6b552557fd65d35ba3c4e109a63ae1c6dca846814d64a9ba4b967949d99b97c0',
       i686: '156e888266fefe1deb148563f3bf5be155b4559a427efd5eb3bd1daab53d5fc4',
     x86_64: '8651fac1f2aa441d3fa318c26e6f3fef4e3dc092d8b4819f46eb2d12404962cc'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
