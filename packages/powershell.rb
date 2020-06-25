require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.0.2'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.2/powershell-7.0.2-linux-arm32.tar.gz'
    source_sha256 '3f884c8eb97cbf28402d5ee5c64c50c556c87779f08a7eb01062c5b7567f9246'
  when 'x86_64'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.2/powershell-7.0.2-linux-x64.tar.gz'
    source_sha256 'e7e458a32c51c6ce43647b8a0eb7fbd9da1b67850c18e389f0eef7c7109891fb'
  end

  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    depends_on 'xdg_base'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.ln_s "#{CREW_PREFIX}/share/powershell/pwsh", "#{CREW_DEST_PREFIX}/bin/pwsh"
  end

  def self.postinstall
    puts
    puts "To get started, execute 'pwsh'".lightblue
    puts
  end
end
