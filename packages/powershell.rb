require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.2.0'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  source_url ({
    aarch64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.0/powershell-7.2.0-linux-arm32.tar.gz',
     armv7l: 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.0/powershell-7.2.0-linux-arm32.tar.gz',
     x86_64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.0/powershell-7.2.0-linux-x64.tar.gz',
  })
  source_sha256 ({
    aarch64: 'bb1e2ca5ff230721ed3d2579714a7cfe12ea27b7b27b22ae222b3515d9038b8c',
     armv7l: 'bb1e2ca5ff230721ed3d2579714a7cfe12ea27b7b27b22ae222b3515d9038b8c',
     x86_64: '15b67d0571d9891a10e541a1462c906084ab148614dd83c6bbddf90046a815a8',
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
