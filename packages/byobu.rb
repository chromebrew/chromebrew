require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2da32465351bcdfe08f0bee4b463c2eb56b60babf9f4fad8e978405d164ad59d',
     armv7l: '2da32465351bcdfe08f0bee4b463c2eb56b60babf9f4fad8e978405d164ad59d',
       i686: '85719bd943a7e38d88ffc3c6b25c21bd23f46b70d5425787d65c67fda51c6eb1',
     x86_64: '3b66b42c13ceff21eb81339a248665b27167d4a9556a527ff79be4d78add98f2'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
