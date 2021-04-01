require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  @_ver = '8.2.2580'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim/archive/v8.2.2580.tar.gz'
  source_sha256 'd0a508ca9726c8ff69bc5f5ab1ebe251c256e01e730f7b36afd03a66c89fcf79'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxd_standalone-8.2.2580-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxd_standalone-8.2.2580-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxd_standalone-8.2.2580-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxd_standalone-8.2.2580-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7faf6e6e092c5913bb627ef7d2e33bd3fa2f3f0ba140773eb676ee267110fdc1',
     armv7l: '7faf6e6e092c5913bb627ef7d2e33bd3fa2f3f0ba140773eb676ee267110fdc1',
       i686: '1026e73efdf2559a2915752529fa2dbd9803e39c2ef604e57dcde28895105089',
     x86_64: 'd84e4ae4abaf14e7ccd5257e9db7366d5131d6726fb3da024f3ac82c37fe42fa'
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
