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
    aarch64: 'cba854d2cd0693a4bdd66d8015fbe3f55eb70305be9dc5347bb0f86be220df17',
     armv7l: 'cba854d2cd0693a4bdd66d8015fbe3f55eb70305be9dc5347bb0f86be220df17',
       i686: '9155b0d9cc7ad2babe49eb25decdb921f43af485a0985db3a8dfe2c6090bb411',
     x86_64: 'a95c50fb409f6a04f30682f0da22057cec1178a1551f6f9776a7a9fa25aa53bc'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
