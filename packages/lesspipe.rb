require 'package'

class Lesspipe < Package
  description 'Input filter for the pager less'
  homepage 'https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html'
  version '2.18'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/wofr06/lesspipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39221026f20d872b11c55607553c247f9c42b241eb42297b7c88ec6c5cbe13a9',
     armv7l: '39221026f20d872b11c55607553c247f9c42b241eb42297b7c88ec6c5cbe13a9',
       i686: '1e6a90cd20229e66589e08cd41b113378eddecda1ce56e22028956515d4ce163',
     x86_64: 'f019a7f7088347b8c2467e2b7aaa1aca70fa87d835549781b58bdaa65fbf98ed'
  })

  depends_on 'less'

  print_source_bashrc

  def self.build
    File.write '10-lesspipe', <<~EOF
      LESSOPEN="|#{CREW_PREFIX}/bin/lesspipe.sh %s"
    EOF
  end

  def self.install
    FileUtils.install %w[lesspipe.sh code2color archive_color vimcolor sxw2txt lesscomplete],
                      "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install '10-lesspipe', "#{CREW_DEST_PREFIX}/etc/env.d/10-lesspipe", mode: 0o644
    FileUtils.install 'less_completion', "#{CREW_DEST_PREFIX}/etc/bash.d/less_completion", mode: 0o644
  end
end
