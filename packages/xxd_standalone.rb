require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  @_ver = '8.2.2783'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/8.2.2783_armv7l/xxd_standalone-8.2.2783-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/8.2.2783_armv7l/xxd_standalone-8.2.2783-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/8.2.2783_i686/xxd_standalone-8.2.2783-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/8.2.2783_x86_64/xxd_standalone-8.2.2783-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '398383f29decea21b375a83861804a76b8a7f5345ea5d8e632430d596836862e',
     armv7l: '398383f29decea21b375a83861804a76b8a7f5345ea5d8e632430d596836862e',
       i686: '25b253e518dd4ad8db7d7ccb4b98b5f68bb84ad242219071c9815cbd77f12c24',
     x86_64: '83d62f69fcb6ee14ba78175affb5a6d11627b2a1b21b84cf61a859e01b011921'
  })

  def self.build
    Dir.chdir 'src/xxd' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        make xxd"
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
