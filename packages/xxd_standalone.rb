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
    aarch64: '63f6d384364bb80e9981fad893cc1b728aa90265fa498e13435504684f8cf911',
     armv7l: '63f6d384364bb80e9981fad893cc1b728aa90265fa498e13435504684f8cf911',
       i686: '26ba9045ce69f85e985df2453fdf40dfbdb681aa84dbf3dfa5ffb17fda760ce7',
     x86_64: 'bfccc6b744a7cae332c1fa5d59a24554561e313bc34ddd2f4bad730458b8508a'
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
