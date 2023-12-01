require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.100.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doctl/1.100.0_armv7l/doctl-1.100.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doctl/1.100.0_armv7l/doctl-1.100.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doctl/1.100.0_x86_64/doctl-1.100.0-chromeos-x86_64.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doctl/1.100.0_i686/doctl-1.100.0-chromeos-i686.tar.zst'
  })
  binary_sha256({
    aarch64: '9de72297695d143c82386eb728114e2169fc384922ce67fa4565050228f6a8ec',
     armv7l: '9de72297695d143c82386eb728114e2169fc384922ce67fa4565050228f6a8ec',
     x86_64: '87919f94bf861fc6b7f5c3320b75fff075553729774d4fc0afe4e6a2878ebc78',
       i686: 'f568369579923bb53c52e628dad85904314a0d6e579c14ca004de298acf7a95d'
  })

  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
