require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.70.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bab1cf4083b57ad47d775435d0627a3a20107d471e680e56b6c1a85b1faaf619',
     armv7l: 'bab1cf4083b57ad47d775435d0627a3a20107d471e680e56b6c1a85b1faaf619',
       i686: 'a548f0a4e7e1e2f376f9b295e5a22da9d9ff16a86c18141c16b04423540bba04',
     x86_64: '52719be0ab0a5739f2846cdfc37bf835ff1ef9633447980e6471c342025cc46c'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
