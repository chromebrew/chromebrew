require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.52.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/junegunn/fzf/releases/download/0.52.0/fzf-0.52.0-linux_armv7.tar.gz',
     armv7l: 'https://github.com/junegunn/fzf/releases/download/0.52.0/fzf-0.52.0-linux_armv7.tar.gz',
     x86_64: 'https://github.com/junegunn/fzf/releases/download/0.52.0/fzf-0.52.0-linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '25763030842a770b3744ae8fa855534e4cbb6f9dfd316b11512fb6c089faabbf',
     armv7l: '25763030842a770b3744ae8fa855534e4cbb6f9dfd316b11512fb6c089faabbf',
     x86_64: '791510a7436713f87034429585e6c19b7ecf5bb1b76089c946e18575aa5fd11f'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
