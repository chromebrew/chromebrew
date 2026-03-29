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
    aarch64: 'e76cafa0592941303284da985d31f00fd4ca5bfd6b5d69b297b9aeac515250d4',
     armv7l: 'e76cafa0592941303284da985d31f00fd4ca5bfd6b5d69b297b9aeac515250d4',
       i686: '0e5af952fffbb06b790937fdbb1af3a375b08020dcfd4af4b0a95ccdc72f1df9',
     x86_64: '90a7c42916416644052d8857dbb05dd83d4a3eee7da38d03a44900821b4834c1'
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
