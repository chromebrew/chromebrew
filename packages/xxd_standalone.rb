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
    aarch64: 'ba5251d23f995e9643de8dafcbe6e8ca13c8af6e6454997b8ff66f08f65c46a8',
     armv7l: 'ba5251d23f995e9643de8dafcbe6e8ca13c8af6e6454997b8ff66f08f65c46a8',
       i686: '122d0b2597c3c2b94c10797d14e7b4412a591c56262046f9b382e94269dd807c',
     x86_64: '597572ffe92b5b9ab6348b7a3a6af942b6be1861911e7e787a99a260f11df311'
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
