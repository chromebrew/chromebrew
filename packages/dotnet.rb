require 'package'

class Dotnet < Package
  description '.NET is the free, open-source, cross-platform framework for building modern apps and powerful cloud services.'
  homepage 'https://dotnet.microsoft.com/'
  version '9.0.306'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.34'
  source_url({
    aarch64: "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     armv7l: "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm.tar.gz",
     x86_64: "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '8036d257f1b12b8d522d20ae6251066fdcf098578100888aff202d8e5305f270',
     armv7l: '8036d257f1b12b8d522d20ae6251066fdcf098578100888aff202d8e5305f270',
     x86_64: '7d64179e044d0ebe709521f760e3c7c7529a8e71e0889cae35181d744ab0228b'
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
