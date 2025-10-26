require 'package'

class Tssh < Package
  description 'Alternative ssh client with additional features.'
  homepage 'https://trzsz.github.io/ssh'
  version '0.1.23'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/trzsz/trzsz-ssh/archive/refs/tags/v#{version}.tar.gz"
  source_sha256 'e4fa0f6f443faede83380ceca4a0de862c054f37c27983a7bbe6bced1d9f80da'

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tssh ./cmd/tssh"
  end
end
