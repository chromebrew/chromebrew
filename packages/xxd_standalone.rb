require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  version '9.0.2190'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.2190_armv7l/xxd_standalone-9.0.2190-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.2190_armv7l/xxd_standalone-9.0.2190-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.2190_i686/xxd_standalone-9.0.2190-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.2190_x86_64/xxd_standalone-9.0.2190-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5ebd390959bcd9e4e44df22c19a84b76a4b3339d6b024044f1923994969f52b3',
     armv7l: '5ebd390959bcd9e4e44df22c19a84b76a4b3339d6b024044f1923994969f52b3',
       i686: '3e03e41e5b59c1368b26dbd96ec44a52455311b519f7a918445ac15c11084ccb',
     x86_64: '77864c03b920834ddeb263a236ff75d4ebb30f61755c54bdbce89c64a7e785ab'
  })

  depends_on 'glibc' # R

  def self.build
    Dir.chdir 'src/xxd' do
      system 'make xxd'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    Dir.chdir 'src/xxd' do
      FileUtils.install 'xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    end
    Dir.chdir 'runtime/doc' do
      FileUtils.install 'xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
    end
  end
end
