require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://learn.microsoft.com/en-us/powershell/'
  version '7.5.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.34'

  source_url({
    aarch64: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-arm32.tar.gz",
     armv7l: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-arm32.tar.gz",
     x86_64: "https://github.com/PowerShell/PowerShell/releases/download/v#{version}/powershell-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '1abedd0bfb0f8c1f0083d8161c6c5842f522292f14b750f0b33169d717835ca4',
     armv7l: '1abedd0bfb0f8c1f0083d8161c6c5842f522292f14b750f0b33169d717835ca4',
     x86_64: '7ebb0048a38009de5a59d620a10f33d7ba4920ace2379b104a67fafb79e2841b'
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
