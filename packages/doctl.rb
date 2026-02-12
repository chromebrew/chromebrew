require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.150.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a18611f8ce441c50d770d4341fcb0e825d6a51ce14ceea3fd9d3a982166ef477',
     armv7l: 'a18611f8ce441c50d770d4341fcb0e825d6a51ce14ceea3fd9d3a982166ef477',
       i686: 'd2fae862f4aaf7876cde3e3e5152cbad1112489d6d7577bab3ef1f905f6e4032',
     x86_64: 'ce8d85fd6ab71d4204753c66366f1886176e7e9850e2be2ce889d0feb320dc52'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
