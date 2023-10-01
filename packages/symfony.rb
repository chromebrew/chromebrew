require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '5.5.10'
  license 'AGPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.10/symfony-cli_linux_armv6.tar.gz',
     armv7l: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.10/symfony-cli_linux_armv6.tar.gz',
       i686: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.10/symfony-cli_linux_386.tar.gz',
     x86_64: 'https://github.com/symfony-cli/symfony-cli/releases/download/v5.5.10/symfony-cli_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '6d42eaf68cb9006a377faf0461fd3078e441d83adebb5a4ae96a7e1c8abf1ca4',
     armv7l: '6d42eaf68cb9006a377faf0461fd3078e441d83adebb5a4ae96a7e1c8abf1ca4',
       i686: 'f08dc545bfa311179443fedbd696acd9d0a6aab7297d77e4511e0fd71e8e0dab',
     x86_64: '6eb8c40f56427f0b00c06df708720429e1f7e06bee8f6902206576460b83707f'
  })

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'symfony', "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end
end
