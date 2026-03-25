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
    aarch64: '9c31988a42dfadc0d64cf1b2aecb004501825e9f2ddcfa9bb5c96027e86d7b70',
     armv7l: '9c31988a42dfadc0d64cf1b2aecb004501825e9f2ddcfa9bb5c96027e86d7b70',
       i686: '01efa67dcf119206d7f0cdb8fcfc4fc9628ff4cfe5e10bdcc0c6caf77dd060fc',
     x86_64: '719b9b0f65bfc7949f77b290347a0d38599ce4c80e1ad27e5d5227b7dd6d1634'
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
