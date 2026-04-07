require 'package'

class Lazygit < Package
  description 'A simple terminal UI for git commands'
  homepage 'https://github.com/jesseduffield/lazygit'
  version '0.61.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_32-bit.tar.gz",
     x86_64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '5d9fed46d7faac69be0a8fe1287ec7b94cf851c786cd557a3294cbdc08781062',
     armv7l: '5d9fed46d7faac69be0a8fe1287ec7b94cf851c786cd557a3294cbdc08781062',
       i686: '63e1e78f4be883a15025d6fc6fe812004dc5474e6a403ddd16c2dc15279219ed',
     x86_64: '4a9702b346283a23a6919c9424617e14788ac00e9cd3c9be266bac48cc6de8eb'
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
