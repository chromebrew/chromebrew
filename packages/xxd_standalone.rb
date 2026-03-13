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
    aarch64: 'ef31e8e3b9bd5fff3820af7ad204f04b13935501ee52772bb255f6667224fd65',
     armv7l: 'ef31e8e3b9bd5fff3820af7ad204f04b13935501ee52772bb255f6667224fd65',
       i686: 'b0fd18ef923939fa782a242cbec68f77b0d51c0add5a8256e379f903750311d0',
     x86_64: '964cf5da2944981a4b206130e84cd040a5d1e01c4578851ec49ebbbbc2dc2e92'
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
