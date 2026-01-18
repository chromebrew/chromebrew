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
    aarch64: '7fa43763fff3f603d9551ac570bd7fdbb7fa65782af26679027eaec4f8e0b06b',
     armv7l: '7fa43763fff3f603d9551ac570bd7fdbb7fa65782af26679027eaec4f8e0b06b',
       i686: '60d6e27aeaffc2e1827f81d8a41c735157ef95ce371181fce0cfe1b4bb61fd08',
     x86_64: 'f5fd48dde0c04fcdb669be6a44e47dbd86566e57b1afc34797aa3daa0da29897'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/trz ./cmd/trz"
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tsz ./cmd/tsz"
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/trzsz ./cmd/trzsz"
  end
end
