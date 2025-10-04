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
    aarch64: '59657cc218a6c49af7f4600e8fde7a6ca7e66c6c2451625ea8cf75015d158599',
     armv7l: '59657cc218a6c49af7f4600e8fde7a6ca7e66c6c2451625ea8cf75015d158599',
       i686: 'a2615b7b87d7462758ab705f21d81b06e7a736a2bc1316e2c5e0ee9276d9271c',
     x86_64: '5e5fa693a0f2b86fb14cfc9300e78a9637c53fd462cb126a10d8ac5c740bdd4d'
  })

  depends_on 'glibc' # R

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
