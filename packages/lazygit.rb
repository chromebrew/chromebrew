require 'package'

class Lazygit < Package
  description 'A simple terminal UI for git commands'
  homepage 'https://github.com/jesseduffield/lazygit'
  version '0.57.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_32-bit.tar.gz",
     x86_64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '2984e480923f8685b5184f497c14e5fe9d4b7890e70ef50fdead3d5846212ae6',
     armv7l: '2984e480923f8685b5184f497c14e5fe9d4b7890e70ef50fdead3d5846212ae6',
       i686: 'cd5c17dab07b0db999ab4691f5e6bcdd700b3402d30d3f447ba1e88f84f2de49',
     x86_64: 'ced011ecd1459d069c66128fbf172b7248c8b99d8983fa17d84a247a98146d5e'
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
