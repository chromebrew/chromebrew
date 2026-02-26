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
    aarch64: 'b6c420c8b5de2adab6928bfbe4169dfdb2a83eaa1377bc768512e1751c05093b',
     armv7l: 'b6c420c8b5de2adab6928bfbe4169dfdb2a83eaa1377bc768512e1751c05093b',
       i686: 'a63bdfde11aba8cffb7c81dfb491572fd939443e4a32c163c43cebc0a4ee922b',
     x86_64: 'aff67b707e295861c6ef960b6163faf3ed891e8af7eabfbef644c5cd58f48229'
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
