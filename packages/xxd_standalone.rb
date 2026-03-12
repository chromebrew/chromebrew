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
    aarch64: 'd3141061ed4d3125825a272e46e9038a080e63ba78d8fbed758f45b1944f8883',
     armv7l: 'd3141061ed4d3125825a272e46e9038a080e63ba78d8fbed758f45b1944f8883',
       i686: '869cf0c63b2d53d72767786603c972a3ead9de3573467715e461acb3427da31b',
     x86_64: '96e02d9bbae7268f358c7f05d525a7e54f306f22bb90552a5b37168325f69080'
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
