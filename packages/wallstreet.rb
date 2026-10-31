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
    aarch64: '8fada5c186593136a21df10c8a7cfe4b85e17b3b9db7b31a10ab0719b2f96dd1',
     armv7l: '8fada5c186593136a21df10c8a7cfe4b85e17b3b9db7b31a10ab0719b2f96dd1',
     x86_64: '9b8e323b8c121197ea064fc6a9f4d022eb4d0da78f6ad701249363ce16e9e76f'
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
