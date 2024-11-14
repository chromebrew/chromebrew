require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.56.1'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '9fa89b553df6b176ef89d2bec0c499fd230bbc97d1e034464bf7908b3ab6d9a7',
     armv7l: '9fa89b553df6b176ef89d2bec0c499fd230bbc97d1e034464bf7908b3ab6d9a7',
     x86_64: '738d892d011839e7347827ededc41b7cb15ce7687f07eaf489ed8eac13872183'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
