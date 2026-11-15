require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.72.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1100a0feda6ccb851f7e85380a2344921c75409e61c81ed9c354a3b1cda9b83a',
     armv7l: '1100a0feda6ccb851f7e85380a2344921c75409e61c81ed9c354a3b1cda9b83a',
       i686: 'e339a1fe822160977e6f07c4e62bc3096f7b714add9ea990e95c67ca7fc5d400',
     x86_64: '2caa281057b5d4f3356aa6834d8581421fc083a39338e47ed9128ba5a3ae938d'
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
