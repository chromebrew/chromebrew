require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '1.8.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cli/cli/archive/refs/tags/v1.8.1.tar.gz'
  source_sha256 '5bdbc589a6d5cca241b2dc467d846a8f23c465d78efd898271f18b636608d6e6'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/github_cli-1.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/github_cli-1.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/github_cli-1.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/github_cli-1.8.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fa3db74e10915c3edb47bc8f92b934dddb5fbb284ba9526c3e207826b3f8f949',
     armv7l: 'fa3db74e10915c3edb47bc8f92b934dddb5fbb284ba9526c3e207826b3f8f949',
       i686: '490bea45749ecc20f57a49e78ea323e45fda376d4437dfa4ecc01f7a34ea972b',
     x86_64: 'c82ab211a3c9653e4f16a6aed36bc377ffa54a6d193b1d51a076dbf91faf1997'
  })

  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 bin/gh #{CREW_DEST_PREFIX}/bin/gh"
  end
end
