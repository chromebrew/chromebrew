require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.16.1'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     armv7l: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     x86_64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '174306b9db01d79085015fad3db3978fb8c2b85acdb7e0b139ffbd46ddca8d14',
     armv7l: '174306b9db01d79085015fad3db3978fb8c2b85acdb7e0b139ffbd46ddca8d14',
     x86_64: 'a059047854004c1e6993256dcc18d7adcc6247c79363f09ec913815523cfb6cb'
  })

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
