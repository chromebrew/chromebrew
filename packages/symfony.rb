require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.8.15'
  license 'AGPL-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.8.15/symfony-cli_linux_armv6.tar.gz',
     armv7l: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.8.15/symfony-cli_linux_armv6.tar.gz',
     x86_64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.8.15/symfony-cli_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '7e7b58ec5f2f024d3db320f1efd1bf6ef4366a77bfcb818088895eb82805378d',
     armv7l: '7e7b58ec5f2f024d3db320f1efd1bf6ef4366a77bfcb818088895eb82805378d',
     x86_64: '885273d6714031c08c7c3fc5377d4f8ed57e0f3be371f64e871dfa72305242e5'
  })

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
