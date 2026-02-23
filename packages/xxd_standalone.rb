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
    aarch64: 'b9ec8ddc9ff249c03c9792e6f15691ab81b4bb671b1fef7e7370ecfb96381db1',
     armv7l: 'b9ec8ddc9ff249c03c9792e6f15691ab81b4bb671b1fef7e7370ecfb96381db1',
       i686: 'b7e2bee52d963f8928b1547c58fd8bcba83c2fa23855be8836c15169e62e57db',
     x86_64: 'f4dc5be9d7b1e30412bb8dfae21aefbd626f052566f24515b1ada9d59c579f71'
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
