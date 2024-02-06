require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.46.1'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/junegunn/fzf/releases/download/0.46.1/fzf-0.46.1-linux_armv7.tar.gz',
     armv7l: 'https://github.com/junegunn/fzf/releases/download/0.46.1/fzf-0.46.1-linux_armv7.tar.gz',
     x86_64: 'https://github.com/junegunn/fzf/releases/download/0.46.1/fzf-0.46.1-linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '594768969ef1ae63cb437eb29f867ed69d0c9d25f083e6b27b1e5b10cb0332a7',
     armv7l: '594768969ef1ae63cb437eb29f867ed69d0c9d25f083e6b27b1e5b10cb0332a7',
     x86_64: '6878dc810c0e464d392985e4e9d3525f7c4af346985f4b094ca117ce1bb0838c'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
