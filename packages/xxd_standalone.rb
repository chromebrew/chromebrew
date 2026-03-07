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
    aarch64: 'ec0bbc327ad345f37da506e02811af3fa8e64fb1f842f5030cc8d45337db26b4',
     armv7l: 'ec0bbc327ad345f37da506e02811af3fa8e64fb1f842f5030cc8d45337db26b4',
       i686: '4e808885d1d49caa7684a43d6856b44442acbc17388411a636c9d4bf14c8c92a',
     x86_64: '28278e7e12879d954d833351f84d0bc2314cdeab4b7944dc483df64ee160bf65'
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
