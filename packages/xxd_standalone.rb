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
    aarch64: 'eace4ee3611dfe8b05190995be9ca0b9c5b9627ca2577efc77744140924bbb33',
     armv7l: 'eace4ee3611dfe8b05190995be9ca0b9c5b9627ca2577efc77744140924bbb33',
       i686: '37d6a92bfb89ed76905acbd5ec0f4b0df8408c421dfe38867b72104504e7948b',
     x86_64: '0570df3291c97b730d24112fe4cc6ee37abdb459af5aa8094cb62aef5ef945a1'
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
