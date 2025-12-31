require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.148.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8c20f273b7a8e7bdb6b3d9907bf987325023bdeba5acc8cbd38e77edd55b07f',
     armv7l: 'f8c20f273b7a8e7bdb6b3d9907bf987325023bdeba5acc8cbd38e77edd55b07f',
       i686: '1f6e651d0e733bd1e56eaf474b055934920808d7aed1ba2f61ddd49c3cb579ac',
     x86_64: 'a6d80d75f25048da7c546d656dc32eef2fcade30c6a0df46781cc92eaae9677e'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
