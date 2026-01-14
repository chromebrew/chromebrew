require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.67.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '915b7280bb0469681495323cc5d460311f26515f34ae8437fe73479c93c65ab9',
     armv7l: '915b7280bb0469681495323cc5d460311f26515f34ae8437fe73479c93c65ab9',
       i686: 'f156ba2709bc1b846595135057fb8140d4d773c6daaf9b8a3948f3765235b415',
     x86_64: '18c72ff3d4d5be9a742ea860b13f8009fdb629587de86490e7b9dab0c965176b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  def self.install
    system "cargo install \
      --locked difftastic \
      --path . --root #{CREW_DEST_PREFIX}"
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/.crate*"]
  end

  def self.postinstall
    ExitMessage.add "\nType 'difft' to get started.\n"
  end
end
