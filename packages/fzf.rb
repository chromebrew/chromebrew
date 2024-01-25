require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.46.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/junegunn/fzf/releases/download/0.46.0/fzf-0.46.0-linux_armv7.tar.gz',
     armv7l: 'https://github.com/junegunn/fzf/releases/download/0.46.0/fzf-0.46.0-linux_armv7.tar.gz',
     x86_64: 'https://github.com/junegunn/fzf/releases/download/0.46.0/fzf-0.46.0-linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'ccc4b6d8cfa66e35066754a8659f54c1a2bc3920bda063ea1f780ed1afa6d135',
     armv7l: 'ccc4b6d8cfa66e35066754a8659f54c1a2bc3920bda063ea1f780ed1afa6d135',
     x86_64: '122da61584a9aef38f23597b0e5f10416ab3a4ad78b6f20d632d03e35ced63c1'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
