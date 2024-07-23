require 'package'

class Dotnet < Package
  description '.NET is the free, open-source, cross-platform framework for building modern apps and powerful cloud services.'
  homepage 'https://dotnet.microsoft.com/'
  version '8.0.303'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     armv7l: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     x86_64: "https://dotnetcli.azureedge.net/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '7514468e178871d8d997435755e7db207d8469e7e2a5f8a8ba018d0fd20d3e9f',
     armv7l: '7514468e178871d8d997435755e7db207d8469e7e2a5f8a8ba018d0fd20d3e9f',
     x86_64: '214ee467f75c42f1512748fe7ca8dd82da2af29cdf54be614a8997f0466ef070'
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
