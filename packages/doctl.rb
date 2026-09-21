require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.169.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49b2dd1cf26b674fe62b1e7b7122d64f313c2a67fc2faff122ecdad6b9ccc57d',
     armv7l: '49b2dd1cf26b674fe62b1e7b7122d64f313c2a67fc2faff122ecdad6b9ccc57d',
       i686: '9f6a8433c205e859994cc86e6adc080af86be2effb0ea6ef801bdd95f6315b62',
     x86_64: '45d5f9011e91ae0a4ca4653a7557985eeb0b37ed139d1ebc852b4025df4996de'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
