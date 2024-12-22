require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.62.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67cd66a4e4c1e96f16819b75b20ffabd43f0586fe3057b2a99a1df59df63e1a0',
     armv7l: '67cd66a4e4c1e96f16819b75b20ffabd43f0586fe3057b2a99a1df59df63e1a0',
       i686: '0202aa02d6bc115f10480901bdc53cf7dfec9130f6873859b035bcb2feae2481',
     x86_64: 'f2706ced7fc57e3b311e449a2db4bfe86489b58d53071ea9e94d2436c9adf954'
  })

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
