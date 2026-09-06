require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.60.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e629a1de32cca01c59d05cb5bdf0069252a9bcb9f674659025b592c90b9c4373',
     armv7l: 'e629a1de32cca01c59d05cb5bdf0069252a9bcb9f674659025b592c90b9c4373',
       i686: '85c8115037ceb4d35f9f47024a9cddebab7a4de3315e017c5477419f92ce64b4',
     x86_64: '939d41c192e51935296a4a93bbdd561ac607093752aa6c05a15cb975c99acc6b'
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
