require 'package'

class Dotnet < Package
  description '.NET is the free, open-source, cross-platform framework for building modern apps and powerful cloud services.'
  homepage 'https://dotnet.microsoft.com/'
  version '8.0.413'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     armv7l: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     x86_64: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '44fc7f81bcabefaaa6fe2c2ec3d87cbc300a40061c81b25601bc5231b1fcbf04',
     armv7l: '44fc7f81bcabefaaa6fe2c2ec3d87cbc300a40061c81b25601bc5231b1fcbf04',
     x86_64: '84ca524028e250f4b676f9ac41c85a34be40383d2f438372c4b5b8d28b61ac88'
  })

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dotnet"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/dotnet"
    FileUtils.ln_s "#{CREW_PREFIX}/share/dotnet/dotnet", "#{CREW_DEST_PREFIX}/bin/dotnet"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-dotnet", "DOTNET_ROOT=#{CREW_PREFIX}/share/dotnet"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dotnet' to get started.\n"
  end
end
