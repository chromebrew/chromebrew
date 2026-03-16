require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://learn.microsoft.com/en-us/powershell/'
  version '7.5.5'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.34'

  source_url({
    aarch64: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-arm32.tar.gz",
     armv7l: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-arm32.tar.gz",
     x86_64: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '26737f8d052b5cdcec551c75f575d2e0b78d4aaa1dadb46c86647860dc7d1df2',
     armv7l: '26737f8d052b5cdcec551c75f575d2e0b78d4aaa1dadb46c86647860dc7d1df2',
     x86_64: '39a62f466956e3606aee6637ed0d0735c1ed27612a76de973b111530ddff2e77'
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
