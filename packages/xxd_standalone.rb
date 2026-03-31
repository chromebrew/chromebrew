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
    aarch64: '80a37c3a2508b6e1da0567c10706b372f72981d4b7102ce8527aade65253c74f',
     armv7l: '80a37c3a2508b6e1da0567c10706b372f72981d4b7102ce8527aade65253c74f',
       i686: 'fd9d03a974c21bc08d66636748a5f772943c105452a5393dcd702337626879d6',
     x86_64: '4e6721191f5d27f75b970e9458cf47d3c84f4310ee06dca6bf0dadbe15c9195a'
  })

  depends_on 'glibc' => :executable

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
