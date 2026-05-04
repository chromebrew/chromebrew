require 'package'

class Tssh < Package
  description 'Highly OpenSSH-compatible client with extended features.'
  homepage 'https://trzsz.github.io/tssh'
  version '0.1.25'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/trzsz/trzsz-ssh.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a73907dbb11bb9eaabf378cdf86a5dbe62a1a42bdbedc98b66f10e4b6012789e',
     armv7l: 'a73907dbb11bb9eaabf378cdf86a5dbe62a1a42bdbedc98b66f10e4b6012789e',
       i686: '3883d5c4b61c67694f3ce5e4f129781cf345bf5e16e2278e2b5240635a57ab9e',
     x86_64: '5679eaf5b8b1368400e54dc09357e8b6131d13cc51f54d179c0005f3c9812308'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tssh ./cmd/tssh"
  end
end
