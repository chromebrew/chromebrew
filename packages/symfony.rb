require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.5.2'
  license 'AGPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.2/symfony-cli_linux_armv6.tar.gz',
     armv7l: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.2/symfony-cli_linux_armv6.tar.gz',
       i686: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.2/symfony-cli_linux_386.tar.gz',
     x86_64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.2/symfony-cli_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '987def27a646ef0f10b47f08149308f635db52dfe74d665d6298daf8d2d8c11c',
     armv7l: '987def27a646ef0f10b47f08149308f635db52dfe74d665d6298daf8d2d8c11c',
       i686: '986d9008af590ead3902a5a490c2183e34284c08cd4d57ad55fc1e82f7c2f05d',
     x86_64: 'ff2966767d14e8c23df9efa16ec13a0b509c30733f354cc1291a14bd3f7d9983'
  })

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
