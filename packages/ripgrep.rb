require 'buildsystems/rust'

class Ripgrep < RUST
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '15.2.0'
  license 'Apache-2.0, BSD-2, Boost-1.0 and MIT or Unlicense'
  compatibility 'all'
  source_url 'https://github.com/BurntSushi/ripgrep.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b7a8062fd9cb4bedd1b52394b4f7423d4f0a82915d77cba7029c805ae8452ab',
     armv7l: '5b7a8062fd9cb4bedd1b52394b4f7423d4f0a82915d77cba7029c805ae8452ab',
       i686: 'b1ff66a6f8b683e8e63640efb6b6a48af0791677c2fa6dea61e8ac2a45950bb8',
     x86_64: '5039e808a0542c47dca18dad9000e095616e2943031f4ad495c4a897d7d3b4b7'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  def self.postinstall
    ExitMessage.add "\nType 'rg' to get started.\n"
  end
end
