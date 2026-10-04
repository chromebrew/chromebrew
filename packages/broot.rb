require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.61.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6107e04cb3e428aef43149b1b58bd7dd8fa2ced4a3f5fb897ae6f8c3e86e74c8',
     armv7l: '6107e04cb3e428aef43149b1b58bd7dd8fa2ced4a3f5fb897ae6f8c3e86e74c8',
       i686: '889214f5376c50d6021e368ecfbbfeb7ab486c1f54991dba5a587bf9a3933d36',
     x86_64: '6d8871dd9ca7dd2bd8a2b9b6bcf207cb12a419607c4cdce2f47b4c23f3791264'
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
