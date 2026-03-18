require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.68.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5ecce7b363e22accaa11a59d870bec4e808c1862cfbda614ef59034ed510bac',
     armv7l: 'c5ecce7b363e22accaa11a59d870bec4e808c1862cfbda614ef59034ed510bac',
       i686: '06caf0d4772cb89ca27735af4b69719f774ee7af81720190a036ba98ec69291c',
     x86_64: 'b8cd8832d04cf84b0afd6e1f461604587dd3fc30bb47568523d0b5025f6f3b94'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
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
