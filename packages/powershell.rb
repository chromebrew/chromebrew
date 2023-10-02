require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.3.7'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'

  source_url({
    aarch64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-arm32.tar.gz',
     armv7l: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-arm32.tar.gz',
     x86_64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: 'f95edb917661f91afbaa968d37ec3c166674f826017d680f954f047ca400b6da',
     armv7l: 'f95edb917661f91afbaa968d37ec3c166674f826017d680f954f047ca400b6da',
     x86_64: '18ab001fe03cf7f3357f1bf0e02e326fbf884dc7c3e98e0e89c6f52bc02cc302'
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
