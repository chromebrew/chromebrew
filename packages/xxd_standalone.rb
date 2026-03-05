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
    aarch64: '70a7026657657feb8ac52405e7e9bb5bccb013ea4322ff88afa7a595a61ae617',
     armv7l: '70a7026657657feb8ac52405e7e9bb5bccb013ea4322ff88afa7a595a61ae617',
       i686: '2bd117916ca12df975ec163b01d4a0e2b51b186fce174c49d635b5367029b778',
     x86_64: 'd8729bc63b2301de5db14484c87ee04d338860e33d9c142f618e313ba23d4f16'
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
