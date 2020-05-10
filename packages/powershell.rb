require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.0.0'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-arm32.tar.gz'
    source_sha256 'cbb6acbb40f73ccf83920f4729dc86ebf3566bb9a01ca68e0698d33fdbe6d7b0'
  when 'x86_64'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-x64.tar.gz'
    source_sha256 '3e80a662a5defb283185961330c4a44d5d5179f9eb2a2ee74ac7e1d3caf16b2c'
  end

  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    depends_on 'xdg_base'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.cp_r Dir.glob('.'), "#{CREW_DEST_PREFIX}/share/powershell"
    FileUtils.ln_s "#{CREW_PREFIX}/share/powershell/pwsh", "#{CREW_DEST_PREFIX}/bin/pwsh"
  end

  def self.postinstall
    puts
    puts "To get started, execute 'pwsh'".lightblue
    puts
  end
end
