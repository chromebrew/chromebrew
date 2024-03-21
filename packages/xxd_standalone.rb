require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  version '9.1.0188'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '244fb157da66a01175118fa7b1f4c9e1b0f31523bf9a975de015b3091b364fef',
     armv7l: '244fb157da66a01175118fa7b1f4c9e1b0f31523bf9a975de015b3091b364fef',
       i686: '994a7d4596c5e864c56ada0a70e70597db13bc41dc570dd9136e9f888ca7dc66',
     x86_64: '833b7e34f728edaa2ac1d472348f7d706c92570d8aeb3260ec384ba017482eb7'
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
