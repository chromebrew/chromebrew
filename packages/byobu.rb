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
    aarch64: 'fc9c058ed3974e0bdba53e0fb4f3c468fc5f85418cbc6137e637b97a0717dad9',
     armv7l: 'fc9c058ed3974e0bdba53e0fb4f3c468fc5f85418cbc6137e637b97a0717dad9',
       i686: '1d0bec29a063308e448561cc929d53388ec2f1c47297ac49fb84500239ee7ffe',
     x86_64: '42f968f9fd48c2baf42db7eae57a23b8047317f08b31c95372bbb19231f89266'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
