require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.166.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83c4422c2ad89aaf8326d45200603f18082daa8df36a3e3a9e21060008718a3c',
     armv7l: '83c4422c2ad89aaf8326d45200603f18082daa8df36a3e3a9e21060008718a3c',
       i686: '784bd1b7ba641ff005cab83e798a6fbdaaeb811529746dc69a72d098c732f35a',
     x86_64: '76fca5c166f99bfe834451a903b1aebb2a9fca9bad8f8dbf27d4832780bb83ba'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
