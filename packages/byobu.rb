require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e6994e2ef1258bf6ca61a9cedcb54f04400e9a861178f9a99ce8e80c9e81a97',
     armv7l: '7e6994e2ef1258bf6ca61a9cedcb54f04400e9a861178f9a99ce8e80c9e81a97',
       i686: 'dd31c5606e9e59e731b129e7263616ea069ea4812b6d553d1e14ee37279171f6',
     x86_64: '09c1e69468bfe01f99f59bb9535f3321ac4072855b4d964c1e8a7b6f9f704fb8'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
