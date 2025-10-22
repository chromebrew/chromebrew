require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.82.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '65cda622ad054487036e0ee8857e505db8d516eee9058aa26590d836ed7653ba',
     armv7l: '65cda622ad054487036e0ee8857e505db8d516eee9058aa26590d836ed7653ba',
       i686: '2eb4ac1955e6a9424477309d57c3851c605eae2f8bb3e83687e25154e9c319a7',
     x86_64: 'afada88676dfccea384e6cc28ae990b3e31bbc55f9d75c4697f902c757fa462b'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
