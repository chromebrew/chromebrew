require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.56.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f93addc4c88f46a300c9e7b4ab773863c2e5337d6194e4441436ae8687eb36e4',
     armv7l: 'f93addc4c88f46a300c9e7b4ab773863c2e5337d6194e4441436ae8687eb36e4',
       i686: '4d79b6ba3b6bcd8915d86dd74dc2994a84a3ecd549fe18fef42792b560b51449',
     x86_64: '3fa5390bff6fa0b7bf81d47a802621107b2c54530ea475b5973a9a1e772c30c1'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/broot")
  end
end
