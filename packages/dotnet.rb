require 'package'

class Dotnet < Package
  description '.NET is the free, open-source, cross-platform framework for building modern apps and powerful cloud services.'
  homepage 'https://dotnet.microsoft.com/'
  version '8.0.101'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://dotnetcli.azureedge.net/dotnet/Sdk/8.0.101/dotnet-sdk-8.0.101-linux-arm.tar.gz',
     armv7l: 'https://dotnetcli.azureedge.net/dotnet/Sdk/8.0.101/dotnet-sdk-8.0.101-linux-arm.tar.gz',
     x86_64: 'https://dotnetcli.azureedge.net/dotnet/Sdk/8.0.101/dotnet-sdk-8.0.101-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: '0d483ab699f82b019385c817c196f7853e8b04545cdac60111dadbc54fda0763',
     armv7l: '0d483ab699f82b019385c817c196f7853e8b04545cdac60111dadbc54fda0763',
     x86_64: '3c61ffcee8947e0ead6196799d058e671b00bc6b983983f2bde5d29f702de2fe'
  })

  no_compile_needed

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
