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
    aarch64: 'a7e729b3d15336a252dc585f151dea6950d870048a4ce6cc73cb62e317be2c76',
     armv7l: 'a7e729b3d15336a252dc585f151dea6950d870048a4ce6cc73cb62e317be2c76',
       i686: 'bbfec6a1e80589b9025fdd7a13aa5f44eeb944be54e7ef78296886f667b1e4ae',
     x86_64: '0b654bcab42ad1970a8054bbe3142981b8a904f9211ed5653153cbb2dbee5f74'
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
