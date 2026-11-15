require 'package'

class Tssh < Package
  description 'Highly OpenSSH-compatible client with extended features.'
  homepage 'https://trzsz.github.io/tssh'
  version '0.1.27'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/trzsz/trzsz-ssh.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d1fe77a0b8ca1e6758770ddbd3ec25d7b66ab69c2c20e855b1fbb15959edc44',
     armv7l: '1d1fe77a0b8ca1e6758770ddbd3ec25d7b66ab69c2c20e855b1fbb15959edc44',
       i686: '7558926c9c117521abdfd3e922d616e076bf643fd45ddd1a9d14c70318baf702',
     x86_64: 'ca8a653070926f6ce55100a5897f52ee2df669da74f12483b49ffb4dfd9ea84d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tssh ./cmd/tssh"
  end
end
