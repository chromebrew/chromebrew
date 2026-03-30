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
    aarch64: '6b8a5a72ad216651b12c1c72fe82380271e1495dbc9a0962ef648d5c0e87a53f',
     armv7l: '6b8a5a72ad216651b12c1c72fe82380271e1495dbc9a0962ef648d5c0e87a53f',
       i686: '74852743b2be5adff8d622ee7298d6e5b6b5aed01194efdcfad9c1b9154dafeb',
     x86_64: '4236d0175bf3e2fb5a1d5b667a6a4b23215486ab665080a40093ada571d106bf'
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
