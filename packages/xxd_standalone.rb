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
    aarch64: '755ea9520d674f7bc80830c28bd7b76cad23b8f2f9b3154711964309c94b6d85',
     armv7l: '755ea9520d674f7bc80830c28bd7b76cad23b8f2f9b3154711964309c94b6d85',
       i686: '53746da8ec5dbf5ca929728f1dac6ff30c66375e7df6177dc6efb2e025342751',
     x86_64: 'a47abbff54cb38c1964a3dec1baea503fca36b613da916c147fec9a1c445a441'
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
