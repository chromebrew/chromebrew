require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  @_ver = '8.2.2771'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xxd_standalone-8.2.2771-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xxd_standalone-8.2.2771-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/xxd_standalone-8.2.2771-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/xxd_standalone-8.2.2771-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f271aa2395a61e7e5dc8c663635dc33c773489df0a6491e75d402638ec9b03d8',
     armv7l: 'f271aa2395a61e7e5dc8c663635dc33c773489df0a6491e75d402638ec9b03d8',
       i686: 'f51c5c9f5cc775f6d312a12a90dd08f35a55332fac1a67cb22180c1c655e6b0d',
     x86_64: '4a765d6217a05f24c124a8fde1d35ae56d636021371a66337d93ce3680f1ab92'
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
