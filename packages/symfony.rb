require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.5.8'
  license 'AGPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.8/symfony-cli_linux_armv6.tar.gz',
     armv7l: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.8/symfony-cli_linux_armv6.tar.gz',
       i686: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.8/symfony-cli_linux_386.tar.gz',
     x86_64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.8/symfony-cli_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '43b1a745ae5d7cf669bfa4791e9018fcda4bbf891179ff3ff60616063bceb329',
     armv7l: '43b1a745ae5d7cf669bfa4791e9018fcda4bbf891179ff3ff60616063bceb329',
       i686: '35105197c72aefdc9e713e4f9d5ca7d4de011fdc34044447af18c87bce3bea0b',
     x86_64: '627e3f6a5da42c47744ed8ea8090cb76ef91f9fc93db8c64f46c508305c34a0a'
  })

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
