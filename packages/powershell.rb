require 'package'

class Powershell < Package
  description 'Powershell is a cross-platform, task-based command-line shell and scripting language that helps rapidly automate tasks that manage operating systems and processes'
  homepage 'https://docs.microsoft.com/en-us/powershell/'
  version '7.0.3'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'armv7l'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-linux-arm32.tar.gz'
    source_sha256 'fe6da9f90fd5026c4ab446a31f565144342a8d507a73d428305bc36c1ad92644'
  when 'aarch64'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-linux-arm64.tar.gz'
    source_sha256 'b5b6db3e5605a6a7675809cd49573f352e1eb6ca9d65890edda1b3f27a8ada56'
  when 'x86_64'
    source_url 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-linux-x64.tar.gz'
    source_sha256 'a9c023940c77a96a9f5135309e44c93ed627983bb1a66ecf5beb42bbba54ead6'
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
