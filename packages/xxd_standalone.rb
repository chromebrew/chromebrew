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
    aarch64: 'b74172d4b7c746f04ab83fb2720732a2ef5d890152ee908243c2796d243b2d67',
     armv7l: 'b74172d4b7c746f04ab83fb2720732a2ef5d890152ee908243c2796d243b2d67',
       i686: '3fbf9b4b6a97547e5cee2643c19337321dc91fbffea4a4fd168af810bb2258cf',
     x86_64: 'b7a07a4536c2d38abe12a310f239f9b594099ac13671f8f75d9cebb936e33bb4'
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
