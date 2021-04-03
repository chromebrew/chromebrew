require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '1.8.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cli/cli/archive/refs/tags/v1.8.1.tar.gz'
  source_sha256 '5bdbc589a6d5cca241b2dc467d846a8f23c465d78efd898271f18b636608d6e6'

  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 bin/gh #{CREW_DEST_PREFIX}/bin/gh"
  end
end
