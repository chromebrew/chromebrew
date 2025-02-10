require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.9.1'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     armv7l: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_armv6.tar.gz",
     x86_64: "https://github.com/symfony-cli/symfony-cli/releases/download/v#{version}/symfony-cli_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '5a5aa4c11ae051af09280fcbde51c4708038d75ebc041b1ca31c3f89d97d7cf3',
     armv7l: '5a5aa4c11ae051af09280fcbde51c4708038d75ebc041b1ca31c3f89d97d7cf3',
     x86_64: '124013c9d3175a98bd6e577c9dd7024d4311ee79e44c201ab8b3531c2b8bd571'
  })

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
