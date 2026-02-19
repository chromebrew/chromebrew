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
    aarch64: 'a64b702f69d63a49a6a6081a16488923566a05c73b0e2982e63a4aff5680c7f5',
     armv7l: 'a64b702f69d63a49a6a6081a16488923566a05c73b0e2982e63a4aff5680c7f5',
       i686: '2f3615ad7b8b8f90e48ce87aed34e7d721db2b2eb8e86b2391f79fb543872e2f',
     x86_64: 'ec19b36b93c2b2f0c49607ceac57b6dd128eaf08016831430afdd2c9e937e010'
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
