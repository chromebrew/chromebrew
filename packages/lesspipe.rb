require 'package'

class Lesspipe < Package
  description 'Input filter for the pager less'
  homepage 'https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html'
  version '2.30'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/wofr06/lesspipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95d2bf5afc57a4dc20e07e9eb584c89362fcd7b05cff6e9663240e2824db88e5',
     armv7l: '95d2bf5afc57a4dc20e07e9eb584c89362fcd7b05cff6e9663240e2824db88e5',
       i686: '3045f058bf7ec586f49038cd073ae5d83a768cd820d23e2088571e962ccbd5b7',
     x86_64: '13c91e0346fe814bd722273864c2da2aecbface5445abcf2378ba87f34a564b7'
  })

  depends_on 'less'

  print_source_bashrc

  def self.build
    File.write '10-lesspipe', <<~EOF
      LESSOPEN="|#{CREW_PREFIX}/bin/lesspipe.sh %s"
    EOF
  end

  def self.install
    FileUtils.install %w[archive_color lesscomplete lesspipe.sh vimcolor],
                      "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install '10-lesspipe', "#{CREW_DEST_PREFIX}/etc/env.d/10-lesspipe", mode: 0o644
    FileUtils.install 'bash_completion', "#{CREW_DEST_PREFIX}/etc/bash.d/less_completion", mode: 0o644
  end
end
