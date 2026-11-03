require 'package'

class Wallstreet < Package
  description 'Fill your console with Wall Street-like news and stats.'
  homepage 'https://a.hollywood.computer/'
  version '1.26'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dustinkirkland/hollywood.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f22b8c48d104ae63dae581f0fa1e3acb4d97f79a14fe1e96be7d79cf8524f6a4',
     armv7l: 'f22b8c48d104ae63dae581f0fa1e3acb4d97f79a14fe1e96be7d79cf8524f6a4',
     x86_64: '9bf1580d4d79febf6324693d709aad86e6a25b8c848308f16b5fe3c6892ae20f'
  })

  depends_on 'byobu' => :logical
  depends_on 'jp2a' => :logical
  depends_on 'libcaca' => :logical
  depends_on 'ncurses' => :logical
  depends_on 'newsboat' => :logical
  depends_on 'perl' => :logical
  depends_on 'procps' => :logical
  depends_on 'python3' => :logical
  depends_on 'rsstail' => :logical
  depends_on 'ticker' => :logical
  depends_on 'tmux' => :logical
  depends_on 'w3m' => :logical
  depends_on 'wget2' => :logical

  no_fhs

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv './lib/wallstreet/', "#{CREW_DEST_PREFIX}/lib/"
    FileUtils.mv './share/wallstreet/', "#{CREW_DEST_PREFIX}/share/"
    FileUtils.install './bin/wallstreet', "#{CREW_DEST_PREFIX}/bin/wallstreet", mode: 0o755
    FileUtils.install './share/man/man1/wallstreet.1', "#{CREW_DEST_MAN_PREFIX}/man1/wallstreet.1", mode: 0o644
  end
end
