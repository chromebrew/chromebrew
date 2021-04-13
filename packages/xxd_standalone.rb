require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  @_ver = '8.2.2725'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/vim/vim/archive/refs/tags/v#{@_ver}.tar.gz"
  source_sha256 'a8aca906cf63fdc4264f86c1c39f8164989de0be3dc18553cb23bd6226c361a9'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xxd_standalone-8.2.2725-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xxd_standalone-8.2.2725-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/xxd_standalone-8.2.2725-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/xxd_standalone-8.2.2725-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2dfdca9a6df73cfcd2d668bde027cf612dac84903d431317dc80ba436e7d6043',
     armv7l: '2dfdca9a6df73cfcd2d668bde027cf612dac84903d431317dc80ba436e7d6043',
       i686: '06af0aab3534058d294e616a41cfe29221e615c9a381d144a82b00379e4dea4d',
     x86_64: '91756fb4d218b84362163da540500ccf10e2e2782a264a86584d5dd6e87a2b25'
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
