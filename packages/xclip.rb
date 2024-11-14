require 'buildsystems/autotools'

class Xclip < Autotools
  description 'Command line interface to the X11 clipboard'
  homepage 'https://github.com/astrand/xclip'
  version '0.13'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/astrand/xclip.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e1520b7cd5d82c87ee68d7777859046ede28f2cc9bacada0d06a4369f9c5dca',
     armv7l: '3e1520b7cd5d82c87ee68d7777859046ede28f2cc9bacada0d06a4369f9c5dca',
     x86_64: 'c01468f5fa173fca162424221aca0e1af2cb4b487aca53c14b6fc287c6e9c83e'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxmu' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install.man'
    File.write 'pbcopy.sh', <<~EOF
      #!/bin/bash
      xclip -i -sel c -f | xclip -i -sel p
    EOF
    FileUtils.install 'pbcopy.sh', "#{CREW_DEST_PREFIX}/bin/pbcopy", mode: 0o755
  end
end
