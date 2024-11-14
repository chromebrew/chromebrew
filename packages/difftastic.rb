require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.60.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a76daf14ae3e2b82c635da690b27d9dfc3e83b22a856d8a1ef0c9ad5e1dfcea7',
     armv7l: 'a76daf14ae3e2b82c635da690b27d9dfc3e83b22a856d8a1ef0c9ad5e1dfcea7',
       i686: 'b766154522964c4b421f9afba18885d87b96a07df295329bf85a5704546ec6d5',
     x86_64: '649c57d13b0a9d234e23b62c5c34b0025859687abb393f2c543c69f804d88b61'
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
