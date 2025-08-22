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
    aarch64: '8c5044a20b2484fb60ecfc8df05d3d59ff06efb6f494dd3f1f488b7bd34617e8',
     armv7l: '8c5044a20b2484fb60ecfc8df05d3d59ff06efb6f494dd3f1f488b7bd34617e8',
       i686: '67d9e017d46ef42c79f531c0534aab3ac434e73271efa993b68a3c5d434b59d6',
     x86_64: '8a768e4a50134ae19eef01dbf62301feba4c4c79be3440193bad4471e1f7c599'
  })

  depends_on 'glibc' # R

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
