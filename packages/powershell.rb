require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://learn.microsoft.com/en-us/powershell/'
  version '7.7.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.34'

  source_url({
    aarch64: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-arm32.tar.gz",
     armv7l: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-arm32.tar.gz",
     x86_64: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: 'd05e2bbc7b165e4db1b7194f92ccb6951e09847d4013f9cc464ead1c8804a10a',
     armv7l: 'd05e2bbc7b165e4db1b7194f92ccb6951e09847d4013f9cc464ead1c8804a10a',
     x86_64: 'c89d9c682d2c403dfe726f3df948e359675235a5bd6fab535776de69729ca0cb'
  })

  depends_on 'xdg_base'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/powershell]
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.chmod 0o755, "#{CREW_DEST_PREFIX}/share/powershell/pwsh"
    FileUtils.ln_s "#{CREW_PREFIX}/share/powershell/pwsh", "#{CREW_DEST_PREFIX}/bin/pwsh"
  end

  def self.postinstall
    ExitMessage.add "\nTo get started, execute 'pwsh'.\n"
  end
end
