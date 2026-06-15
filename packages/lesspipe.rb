require 'package'

class Lesspipe < Package
  description 'Input filter for the pager less'
  homepage 'https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html'
  version '2.27'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/wofr06/lesspipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd6525d466b9331209db7757fa5a91e52a10ad09350c3e05618f47ff9519be17',
     armv7l: 'bd6525d466b9331209db7757fa5a91e52a10ad09350c3e05618f47ff9519be17',
       i686: '545318a50139f171be312a4eadf560deea7e73d24e3cf9860f50e9457e85f6d4',
     x86_64: 'fbf5435348f91bb6689e5d61977bd77134a16e0b9d81d067d4b702985f5ad864'
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
