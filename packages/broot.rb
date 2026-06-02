require 'buildsystems/rust'

class Broot < RUST
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot/'
  version '1.57.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '884c7951f8bc7c7b0644efe788d9a06aab7fea0040d20f5f6fd883465b8ed7ef',
     armv7l: '884c7951f8bc7c7b0644efe788d9a06aab7fea0040d20f5f6fd883465b8ed7ef',
       i686: '742a37c84d4678c4c56e56585760f4527988b789da39bef4fbc95e9860ac5279',
     x86_64: 'd6a64dc911bd31ef25f6f19d7a4b71796af26a29a4a1045ddf28bb0082b04c69'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/broot")
  end
end
