require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.3.6'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'

  source_url({
    aarch64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/powershell-7.3.6-linux-arm32.tar.gz',
     armv7l: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/powershell-7.3.6-linux-arm32.tar.gz',
     x86_64: 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/powershell-7.3.6-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: '0bd7759895546ac04ed81368c7818036fc8b2d9826e476f0f249dab51a30797b',
     armv7l: '0bd7759895546ac04ed81368c7818036fc8b2d9826e476f0f249dab51a30797b',
     x86_64: '38bfba9aa4c914adf9f9a64b7f5832f8533305b696b5f03d0c3d56f9a2d8a5dc'
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
