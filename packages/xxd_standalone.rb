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
    aarch64: 'f5965e9239d8acdaa1b9c4a72fb51fba227b08f0ce21b1d768ea9806db66b75e',
     armv7l: 'f5965e9239d8acdaa1b9c4a72fb51fba227b08f0ce21b1d768ea9806db66b75e',
       i686: '7c3d38b094a2992a83dadc7e719730beb5145dcc6772e8e586bf0084d7ebe12b',
     x86_64: 'cd3112dfc78d0a1e88a2f8b2be2709ac04ccdd66011913dda886ce3652a142e7'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
