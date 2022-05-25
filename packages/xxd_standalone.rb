require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  version '9.1.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.1.0_armv7l/xxd_standalone-9.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.1.0_armv7l/xxd_standalone-9.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.1.0_i686/xxd_standalone-9.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.1.0_x86_64/xxd_standalone-9.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e439a0154451ef47f7d4764107ad0aa39bff0e1ac0bc2956db0ab9d6db8920f1',
     armv7l: 'e439a0154451ef47f7d4764107ad0aa39bff0e1ac0bc2956db0ab9d6db8920f1',
       i686: 'c4ca11a5b03b319aad1b95b459f4da91fd1c31d191112c8c75377187538f1bbb',
     x86_64: '4c21e2969ca4a238ee02405c9164cf33b1eeca244c3f18ef0c749bed11310094'
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
