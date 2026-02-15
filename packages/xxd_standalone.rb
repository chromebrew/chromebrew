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
    aarch64: 'd55849bf3e880876628817e54e1fd36e82d24b89dd93e1ebb0bfadc83d988690',
     armv7l: 'd55849bf3e880876628817e54e1fd36e82d24b89dd93e1ebb0bfadc83d988690',
       i686: 'd7d0ef51338ebe3f9dc24af4c11131155145fe0d283bcc2b3a52484f4692006b',
     x86_64: '363d83f27afd029325e0cffa7899cec73b44ea6a33e95d4109a96b12720f303e'
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
