require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.3.3'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'

  source_url({
    aarch64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/powershell-7.3.3-linux-arm32.tar.gz',
     armv7l: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/powershell-7.3.3-linux-arm32.tar.gz',
     x86_64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/powershell-7.3.3-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: '8f10ade3bd12a21fba51bcaaecb12b79cb11092725ac0f7c7e6947c053053766',
     armv7l: '8f10ade3bd12a21fba51bcaaecb12b79cb11092725ac0f7c7e6947c053053766',
     x86_64: '478320f62c9bec5765414b82b4086310777bf95ab2fc2310b2db6cbc253b40b4'
  })

  depends_on 'xdg_base'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/powershell]
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.ln_s "#{CREW_PREFIX}/share/powershell/pwsh", "#{CREW_DEST_PREFIX}/bin/pwsh"
  end

  def self.postinstall
    puts "\nTo get started, execute 'pwsh'.\n".lightblue
  end
end
