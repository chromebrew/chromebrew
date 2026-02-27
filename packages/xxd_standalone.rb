require 'package'
Package.load_package("#{__dir__}/vim_runtime.rb")

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'https://www.vim.org/'
  version Vim_runtime.version
  license 'GPL-2'
  compatibility 'all'
  source_url Vim_runtime.source_url
  git_hashtag Vim_runtime.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16c2c245a9ea784b2e3636cd1665f4746060b1f3eb72f4dec3c20af94a5a09e3',
     armv7l: '16c2c245a9ea784b2e3636cd1665f4746060b1f3eb72f4dec3c20af94a5a09e3',
       i686: 'd72ece792fa8d8f0f9a0bcde137f3b4a5ca3947fb85145def52df4a7d79fcafd',
     x86_64: '1566840aa04a773f31745f9fe020fbc7f1b389340abd637b6e08a6efc8d9898c'
  })

  depends_on 'glibc' => :executable_only

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
