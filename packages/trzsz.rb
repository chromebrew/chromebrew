require 'package'

class Trzsz < Package
  description 'Simple file transfer tools, similar to lrzsz (rz/sz), and compatible with tmux.'
  homepage 'https://trzsz.github.io'
  version '1.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/trzsz/trzsz-go.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee0c1d36bd136bee8fc4acff260191acd5d8bce505e3e592f050d9a718d530d5',
     armv7l: 'ee0c1d36bd136bee8fc4acff260191acd5d8bce505e3e592f050d9a718d530d5',
       i686: '8ad1cbd074aa7ff0dfe9447959f3320ba78c7f455334e9685f85e3847fd1097f',
     x86_64: '35f74a16ce3ad9532f7cdd8a5ae27e7f92ce6c46b252c7b59c7eab6d83148e13'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/trz ./cmd/trz"
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tsz ./cmd/tsz"
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/trzsz ./cmd/trzsz"
  end
end
