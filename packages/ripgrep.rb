require 'buildsystems/rust'

class Ripgrep < RUST
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '16.0.0'
  license 'Apache-2.0, BSD-2, Boost-1.0 and MIT or Unlicense'
  compatibility 'all'
  source_url 'https://github.com/BurntSushi/ripgrep.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7de186cd444e4be38f566b95e499e87f2b1f6f70606a563a47b5f3978d9ec975',
     armv7l: '7de186cd444e4be38f566b95e499e87f2b1f6f70606a563a47b5f3978d9ec975',
       i686: 'a16bca9e3be63c3bf63e5d4db10814d6b2b166f13c4d69f48943521376609be9',
     x86_64: '7aefeea5fb67cd77e65aa8a854f9b2f58a70dd48482fe3259dcebf95244cd768'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  def self.postinstall
    ExitMessage.add "\nType 'rg' to get started.\n"
  end
end
