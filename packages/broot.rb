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
    aarch64: 'aac60abf4b60b03fd75303e42e9dda18d05f39223fe411a64e99df04a4b441e8',
     armv7l: 'aac60abf4b60b03fd75303e42e9dda18d05f39223fe411a64e99df04a4b441e8',
       i686: '93f801e86ad2faf500e15fee56b493f6518df4be38e01c350b6fd0f762fe4af8',
     x86_64: '3012d20fd18a37ca010ddcee6a1df31bf20645f966a6c673b00c6cfc02f6e7c1'
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
