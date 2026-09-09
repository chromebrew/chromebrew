require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.60.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e04419987ffcbdde1bd6e5229428347ed3606d947fcdea7ebc9c627fd355e28b',
     armv7l: 'e04419987ffcbdde1bd6e5229428347ed3606d947fcdea7ebc9c627fd355e28b',
       i686: 'd773efcbb4fa5b784cef9db1dec5ba0d11da6752266a9107bde3cc61ed90b744',
     x86_64: '5f78206eaef5655e21c4ceebbfad703d92b9f16f1beb26ded9bfb34a66ecb406'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/broot")
  end
end
