require 'package'

class Dotnet < Package
  description '.NET is the free, open-source, cross-platform framework for building modern apps and powerful cloud services.'
  homepage 'https://dotnet.microsoft.com/'
  version '8.0.403'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     armv7l: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     x86_64: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '2244b19913c32aa0b60ae91def84528ddd7ec031cb9f3e78db4857088749eeec',
     armv7l: '2244b19913c32aa0b60ae91def84528ddd7ec031cb9f3e78db4857088749eeec',
     x86_64: 'f7c31f1397444aab91afbef8d8a46e36531443faced60fa9d4070cf15a81b256'
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
    ExitMessage.add "\nType 'dotnet' to get started.\n".lightblue
  end
end
