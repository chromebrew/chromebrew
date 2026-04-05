require 'package'

class Wallstreet < Package
  description 'Fill your console with Wall Street-like news and stats.'
  homepage 'https://a.hollywood.computer/'
  version '1.25'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dustinkirkland/hollywood.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '146ccb4f0733b892c7458cf0ee39057c9150b3235d6b5a30c44470664e7e4123',
     armv7l: '146ccb4f0733b892c7458cf0ee39057c9150b3235d6b5a30c44470664e7e4123',
     x86_64: 'd62743dff4ca8b8ccd347a692e93f2281b9e88d380ee8c90bca7f34b5617fdb4'
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

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.cp './bin/wallstreet', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp_r './lib/wallstreet/', "#{CREW_DEST_PREFIX}/lib/"
    FileUtils.cp_r './share/wallstreet/', "#{CREW_DEST_PREFIX}/share/"
    FileUtils.cp './share/man/man1/wallstreet.1', "#{CREW_DEST_MAN_PREFIX}/man1/"
  end
end
