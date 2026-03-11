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
    aarch64: 'ac2cad1d669bdf9bb38ce3c31510d2c3dc4c3ba63088b126714da17cfddf1c09',
     armv7l: 'ac2cad1d669bdf9bb38ce3c31510d2c3dc4c3ba63088b126714da17cfddf1c09',
       i686: 'e7e742f84b4f8d8763e4197a28d59e2cf7283728198eca3ae1537b4322f4e5b3',
     x86_64: '2482d52cefa7e61880e5621a6d5f4b416c6b70db7ff24eb9277b8e9d4eb833a2'
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
