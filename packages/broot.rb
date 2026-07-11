require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.58.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5579cf483729a213d71c64164663f7a995abf062c13996cd6501270c5f8b58db',
     armv7l: '5579cf483729a213d71c64164663f7a995abf062c13996cd6501270c5f8b58db',
       i686: 'd3ab0d2e8102f21ab3ef996135b8ca49c6640b685c0338cd9aea4e92ba859fec',
     x86_64: '7f5283d547be43cbd60ed43f9664c6663bd1205b2b82f8bd0ddf241d69ea54f6'
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
