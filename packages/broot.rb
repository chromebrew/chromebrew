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
    aarch64: 'e281e8fa50a5d863397b915fa77f59226e7dacb254a410ea0547340c9b1dbba8',
     armv7l: 'e281e8fa50a5d863397b915fa77f59226e7dacb254a410ea0547340c9b1dbba8',
       i686: '4419a608bd2038e4fd4068731484fe3fd65c0e8d6dd7849e125ea93a62f1d399',
     x86_64: '9b2ec3eff8ac2dc77f9fecd7f01b6d72a7ecc1185f1d2500405cd161ce4d3970'
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
