require 'package'

class Lazygit < Package
  description 'A simple terminal UI for git commands'
  homepage 'https://github.com/jesseduffield/lazygit'
  version '0.63.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_32-bit.tar.gz",
     x86_64: "https://github.com/jesseduffield/lazygit/releases/download/v#{version}/lazygit_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'a2507f70e95d9cf70f003a1275489919806263bca94c2dee868de83e2cd2ec6e',
     armv7l: 'a2507f70e95d9cf70f003a1275489919806263bca94c2dee868de83e2cd2ec6e',
       i686: 'df8029f0b4899561a3420835fd0ae9cf16627385afb51c29865e0d8626caa1e5',
     x86_64: '8e033bc78c8e192dee9510e951f6c9e154289b7198d22c924ed1d0a951b0dac1'
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
