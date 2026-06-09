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
    aarch64: '43d1d801cfb186c5f4a4a34a18cb8c42e5fa52f61b6eec36f6875d7f0d255cec',
     armv7l: '43d1d801cfb186c5f4a4a34a18cb8c42e5fa52f61b6eec36f6875d7f0d255cec',
       i686: '21787aeb50e0dee2a893cd4be98e74087ab6d89a56feff630d46b03604a9db6a',
     x86_64: '1b42e9c1ccc79cf02d09660bd9b8dcfb6ca029b66efc3e1186de404f51df3547'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
