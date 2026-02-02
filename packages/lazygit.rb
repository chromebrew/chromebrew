require 'package'

class Lazygit < Package
  description 'A simple terminal UI for git commands'
  homepage 'https://github.com/jesseduffield/lazygit'
  version '0.58.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_32-bit.tar.gz",
     x86_64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'ca30bfdff93856095690623f5c45995a3369e197e139f65e6f55c9c2791fcb2a',
     armv7l: 'ca30bfdff93856095690623f5c45995a3369e197e139f65e6f55c9c2791fcb2a',
       i686: 'ea5e6ca5ef78d174db9c3d3b70f80022019093802563736c5ecb0963b797fe34',
     x86_64: '61b6b839390c193466fb692f75df4e75ef5e9ced2bf5e0ca8b3848902f0adea9'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'lazygit', "#{CREW_DEST_PREFIX}/bin/lazygit", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'lazygit' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.local/state/lazygit")
  end
end
