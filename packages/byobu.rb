require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fae97c2055e22f1c7426b2ee58592c2cd1649e904c552d1c4254479a06a2608d',
     armv7l: 'fae97c2055e22f1c7426b2ee58592c2cd1649e904c552d1c4254479a06a2608d',
       i686: 'a5ca3b37b3e230b845cd15754e91d189b5e59039dfe74ecbc5e734d75351b125',
     x86_64: 'bafe968bd5150b1c2c66f06e9bcceeaaafdd89b14e92cdc7d5740d3542e9812b'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
