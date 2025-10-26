require 'package'

class Trzsz < Package
  description 'Simple file transfer tools, similar to lrzsz (rz/sz), and compatible with tmux.'
  homepage 'https://trzsz.github.io'
  version '1.1.8'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/trzsz/trzsz-go/archive/refs/tags/v#{version}.tar.gz"
  source_sha256 '9ff477c98081ffccecdd61b1bb51d573a0b67c7d205ecfc9d50b20dd4b54f3f1'

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/trz ./cmd/trz"
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tsz ./cmd/tsz"
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/trzsz ./cmd/trzsz"
  end
end
