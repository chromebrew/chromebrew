require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.62.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e37beb434b157e908f967142b698a9fec512e169617fb8bfb0560600b3cb9b0c',
     armv7l: 'e37beb434b157e908f967142b698a9fec512e169617fb8bfb0560600b3cb9b0c',
       i686: '374ab1f4ba0a6e877e433b7e35cf6c6b1f79142d86254c207983a012f704c147',
     x86_64: '4cd33bdb05812d557872372698a559ed23dd0528388d61f820680f5445f16cb7'
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
