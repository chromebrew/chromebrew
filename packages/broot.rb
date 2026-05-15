require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.56.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fda7e60ac254d2e5fa8f9f15808a7baf21949c0bd5340411fc67737318b9151',
     armv7l: '1fda7e60ac254d2e5fa8f9f15808a7baf21949c0bd5340411fc67737318b9151',
       i686: '0b81f9a3309096816005a587160b25ffc0f01b8b25ac5535a54ed7b2a7b21919',
     x86_64: '23d74f1d5d3ea1c70cc38bf51ff7d3f5f0e3108974246d2185bf06780190a3fa'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/broot")
  end
end
