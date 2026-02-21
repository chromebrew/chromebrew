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
    aarch64: '017f1ef26335f70be051a28c0a42a22f953094a2a456a91f98d412fc0eb31a2d',
     armv7l: '017f1ef26335f70be051a28c0a42a22f953094a2a456a91f98d412fc0eb31a2d',
       i686: 'ff1c88415426b918366f1f196db4f77dc411dba86113c3ed983abf1995f6e196',
     x86_64: '22d270674cf2d77885559199451ec1bd05ae34296f92868e071a02f46389a855'
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
