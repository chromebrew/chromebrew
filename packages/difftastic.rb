require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.71.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f475cea0230b9f162107f8df203f011f6207e73f72375dafd95e1d77e064a8ca',
     armv7l: 'f475cea0230b9f162107f8df203f011f6207e73f72375dafd95e1d77e064a8ca',
       i686: '9efdaa814bca46c36cf9f89f7458830309a4a62cc1749bfb34927ab2a7e3fb45',
     x86_64: '0e34f463c5cea9b94c2d983b09a64b51973341701db6fca9f7c4f63342c70b84'
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
