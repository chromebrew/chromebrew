require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.2.1'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  source_url({
    aarch64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-7.2.1-linux-arm32.tar.gz',
     armv7l: 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-7.2.1-linux-arm32.tar.gz',
     x86_64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-7.2.1-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: 'd40ca2c8e05dd8b6169d7f35683432c671a3c58f35e46deaf1d776d9a78b38fe',
     armv7l: 'd40ca2c8e05dd8b6169d7f35683432c671a3c58f35e46deaf1d776d9a78b38fe',
     x86_64: '337d9864799ad09b46d261071b9f835f69f078814409bc2681f4cc2857b6bda5'
  })

  depends_on 'xdg_base'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.ln_s "#{CREW_PREFIX}/share/powershell/pwsh", "#{CREW_DEST_PREFIX}/bin/pwsh"
  end

  def self.postinstall
    puts "\nTo get started, execute 'pwsh'.\n".lightblue
  end
end
