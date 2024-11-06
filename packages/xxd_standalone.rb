require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'https://www.vim.org/'
  version '9.1.0754'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce3214bcb20f591aca75497f1be94d0ee24b962214310b944d9ceacc7c06d883',
     armv7l: 'ce3214bcb20f591aca75497f1be94d0ee24b962214310b944d9ceacc7c06d883',
       i686: '8af40856fa71e8ba389a759043efaa5448691ff907550c54989ab0a2447fde4c',
     x86_64: '3c363bdb4841a3dfbc324a485dd9456a2ae2fe82e0336c989f6ebd7b1c38132d'
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
