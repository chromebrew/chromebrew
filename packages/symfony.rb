require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.7.5'
  license 'AGPL-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.7.5/symfony-cli_linux_armv6.tar.gz',
     armv7l: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.7.5/symfony-cli_linux_armv6.tar.gz',
     x86_64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.7.5/symfony-cli_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '00221a0045dfbc980a18bead0c174041f8cbc4f63e4ff3c81d8cf391f353e510',
     armv7l: '00221a0045dfbc980a18bead0c174041f8cbc4f63e4ff3c81d8cf391f353e510',
     x86_64: '584e69add9bcb3bbf0c82c4da626c52924428181c85820a20c7f355e427eccac'
  })

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
