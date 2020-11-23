require 'package'

class Dotnet_core < Package
  description '.NET, an open-source developer platform for building many different types of applications.'
  homepage 'https://dot.net'
  version '3.1.404'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://download.visualstudio.microsoft.com/download/pr/2ebe1f4b-4423-4694-8f5b-57f22a315d66/4bceeffda88fc6f19fad7dfb2cd30487/dotnet-sdk-3.1.404-linux-arm.tar.gz'
    source_sha256 'c95e8cf72abbcde1ac3974158ed9355d8d5588bade463fdf69d6932f915f453a'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://download.visualstudio.microsoft.com/download/pr/ec187f12-929e-4aa7-8abc-2f52e147af1d/56b0dbb5da1c191bff2c271fcd6e6394/dotnet-sdk-3.1.404-linux-x64.tar.gz'
    source_sha256 '6b8dd87de54bd855968325feec9cf57e2fb4b0dba745591d48d71eb2b8d7280d'
    @arch = 'x64' 
  end

  # icu, curl, glibc, openssl, zlib, kerberos5

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system 'export DOTNET_CLI_TELEMETRY_OPTOUT=1'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dotnet"
    system "install -dm 755 #{CREW_DEST_PREFIX}/share/{dotnet,dotnet/packs,licenses}"
    system "cp -dr --no-preserve='ownership' sdk templates #{CREW_DEST_PREFIX}/share/dotnet/"
    system "export DOTNET_ROOT=#{CREW_PREFIX}/share/dotnet"
    system "export PATH=$PATH:#{CREW_PREFIX}/share/dotnet"
  end

  def self.postinstall
    puts
    puts "All things dotnet are in #{CREW_PREFIX}/share/dotnet.".lightblue
    puts
    puts "echo 'export DOTNET_CLI_TELEMETRY_OPTOUT=1' >> ~/.bashrc".lightblue
    puts "echo 'export DOTNET_ROOT=#{CREW_PREFIX}/share/dotnet' >> ~/.bashrc".lightblue
    puts "echo 'export PATH=$PATH:#{CREW_PREFIX}/share/dotnet' >> ~/.bashrc && source ~/.bashrc".lightblue
  end

end
