require 'package'

class Tssh < Package
  description 'Highly OpenSSH-compatible client with extended features.'
  homepage 'https://trzsz.github.io/tssh'
  version '0.1.26'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/trzsz/trzsz-ssh.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b023103b0aaebd903cd1df53a4f9f85d496504deda8190fbf7be5c573330bc60',
     armv7l: 'b023103b0aaebd903cd1df53a4f9f85d496504deda8190fbf7be5c573330bc60',
       i686: '3f68bc2d2d77d2358aed9c629c4c91dc6aae65cd25db3f6c2db0063aee429c02',
     x86_64: 'bf2394c380a5a5ad9e9de68dc35cf4c6e0e0060f10b58cf8b1aa7a61e72d1552'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tssh ./cmd/tssh"
  end
end
