require 'package'

class Lazygit < Package
  description 'A simple terminal UI for git commands'
  homepage 'https://github.com/jesseduffield/lazygit'
  version '0.61.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_32-bit.tar.gz",
     x86_64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '2ac388c083a26fdd1f1e21da3e3f1093240f4889c997e96eb9cb0a2a80793041',
     armv7l: '2ac388c083a26fdd1f1e21da3e3f1093240f4889c997e96eb9cb0a2a80793041',
       i686: 'e95dad3a5dd477050301f273c6de2fb801938bf0a7d52fd9de68eaeb1ea71377',
     x86_64: '1b91e660700f2332696726b635202576b543e2bc49b639830dccd26bc5160d5d'
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
