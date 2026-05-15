require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.0.4'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'b95234031941ed9968cacbf5beea18c170a10229fb6cdf584afebfe1b24e2907',
     armv7l: 'b95234031941ed9968cacbf5beea18c170a10229fb6cdf584afebfe1b24e2907',
       i686: '92443e49a04c4bb85bdf1e3b84c888934decd536169f3249db146bd4be023108',
     x86_64: 'b9ee4e690dd4d516c52c4dc71988caba474fc804a28daaf0760fbda3030ff95d'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'lego', "#{CREW_DEST_PREFIX}/bin/lego", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'lego' to get started.\n"
  end
end
