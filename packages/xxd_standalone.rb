require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'https://www.vim.org/'
  version '9.1.0969'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db075ea407728925266aede8d5c7c4f29b318cc696d21ef6c250840bbff174e0',
     armv7l: 'db075ea407728925266aede8d5c7c4f29b318cc696d21ef6c250840bbff174e0',
       i686: '8b68b374812c8f12987be4a1294ecf772850405f157fc769a3a394c8f400d929',
     x86_64: '8fa7ce57b97542413a0175822d537d0bb0a6a134a78dd0501525de1ebfb29d6a'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
