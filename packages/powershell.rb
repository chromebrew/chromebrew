require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.4.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'

  source_url({
    aarch64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-7.4.2-linux-arm32.tar.gz',
     armv7l: 'https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-7.4.2-linux-arm32.tar.gz',
     x86_64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-7.4.2-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: '6bf11145e6d15ea8a89d9167bdcef0d75848462e4369c837fda37a6550d2dc5f',
     armv7l: '6bf11145e6d15ea8a89d9167bdcef0d75848462e4369c837fda37a6550d2dc5f',
     x86_64: '36605dc37979de5af2e10783bf70c0ad8150521e81e6d7c9322036ebb897e7fe'
  })

  depends_on 'xdg_base'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/powershell]
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.ln_s "#{CREW_PREFIX}/share/powershell/pwsh", "#{CREW_DEST_PREFIX}/bin/pwsh"
  end

  def self.postinstall
    ExitMessage.add "\nTo get started, execute 'pwsh'.\n".lightblue
  end
end
