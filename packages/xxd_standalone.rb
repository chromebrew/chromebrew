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
    aarch64: 'b2dcafcb6b59bcc5fdbacf0fea2c82d4cfb3f68d1c9da9a1db278e138027c1aa',
     armv7l: 'b2dcafcb6b59bcc5fdbacf0fea2c82d4cfb3f68d1c9da9a1db278e138027c1aa',
       i686: '11c07b8d79d88f934b86e2dea2297ebe48440ccf6278f0a642dcace7ffe53ea4',
     x86_64: '47905d165dbb3b4a64ebcfcbe21d18f5d53834428238d7eedabe1f5ad7594981'
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
