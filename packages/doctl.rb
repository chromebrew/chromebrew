require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.154.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea5f67ee5cf83d645918adaae581522e55c24b1f9addb35e14f2a8a629d14f1f',
     armv7l: 'ea5f67ee5cf83d645918adaae581522e55c24b1f9addb35e14f2a8a629d14f1f',
       i686: 'f35e42bef8763f9e7acc7fb2d7f684e1149cdfd5e361c59c0186c61fe7b1aca0',
     x86_64: 'ee96553ef7daf1267b938fef9f2dd8e81d8f0f13a43c7a63f3699b452a1ed106'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
