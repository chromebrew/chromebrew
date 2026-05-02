require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.69.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '777867be4b4a5796606b2a4d766337b05d16cef529b49a3103fd4fb136ab7ac2',
     armv7l: '777867be4b4a5796606b2a4d766337b05d16cef529b49a3103fd4fb136ab7ac2',
       i686: 'f2765af879443f080a9c2d5067dc08250df30889ee406d6d9bf0afd9fd392298',
     x86_64: 'a157fd303b0213943aba054edc3ab4ea44cf62bff407005cd5b77d9fb614424e'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
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
