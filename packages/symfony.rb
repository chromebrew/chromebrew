require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.15.1'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     armv7l: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     x86_64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'd1e1cf448ae1756188573a1355b56722284b1d0faf1699482de172c029a02dd3',
     armv7l: 'd1e1cf448ae1756188573a1355b56722284b1d0faf1699482de172c029a02dd3',
     x86_64: '2a420e72a4c0e049fa20a276c7ab3b9a006b55405c2396700740516d4031e797'
  })

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
