require 'package'

class Tssh < Package
  description 'Alternative ssh client with additional features.'
  homepage 'https://trzsz.github.io/ssh'
  version '0.1.24'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/trzsz/trzsz-ssh.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3095f5fb8d513765c4500b4b1e4f3ae6275576c511591d6abf71cad986e84cbf',
     armv7l: '3095f5fb8d513765c4500b4b1e4f3ae6275576c511591d6abf71cad986e84cbf',
       i686: 'cbacc9d542c6fb8cae1bbfeaf2c55484afa4e1b2d39a111a8b9eda5cef94d65a',
     x86_64: 'b456de5a943981b89c3c2a5caed99c20ea9afe7b7339c3b378c00237e0d8ed71'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tssh ./cmd/tssh"
  end
end
