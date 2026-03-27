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
    aarch64: '9250a9fa9dd7d5220384343709489aefc620c894cbc2bc5799bbe2935ac5b7c3',
     armv7l: '9250a9fa9dd7d5220384343709489aefc620c894cbc2bc5799bbe2935ac5b7c3',
       i686: 'f860bf97155c672666c0db12d4e7f1f0324f3e0288ace71c273b1308ddeb1b43',
     x86_64: '95f8d4c2c6f178b0ebb9f79f87a281a38b63208c9792d49e15fee06ba809dc23'
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
