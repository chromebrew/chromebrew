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
    aarch64: '2a2e066ce4142150122139960e47c9d3a177bf35249fa7e3c7e8a9453033d282',
     armv7l: '2a2e066ce4142150122139960e47c9d3a177bf35249fa7e3c7e8a9453033d282',
       i686: '4fb8ac25bd22b6affa3e62647c6ac4325b57122cd977898ebf4accf289a063ef',
     x86_64: '99a551633aa66f4f873553b1f283736fa91a39ecd08b97a260f91b505f756828'
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
