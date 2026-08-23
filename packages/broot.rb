require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.59.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ff3478a2deb97123dd24288b3e432e844855c86e39a6064c420eca063a23606',
     armv7l: '1ff3478a2deb97123dd24288b3e432e844855c86e39a6064c420eca063a23606',
       i686: 'b7ca635e398481d7b420a5c8e27b9bf6354f7e616886ae833eb1cdadb75c0007',
     x86_64: '0108d494d9ac163aa0e203a06c790acdd89cf829014c21ef3e91e531d8be3785'
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
