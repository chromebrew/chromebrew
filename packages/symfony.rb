require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.16.0'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     armv7l: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     x86_64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'a863020fd0408dc58a8618a06244953e7d717a4ecdeae0352c8291bd598374f1',
     armv7l: 'a863020fd0408dc58a8618a06244953e7d717a4ecdeae0352c8291bd598374f1',
     x86_64: '944c08b63f3e083302863e3e28d19867400990d88706ff560cff8db2359096fd'
  })

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
