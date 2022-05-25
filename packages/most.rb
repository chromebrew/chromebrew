require 'package'

class Most < Package
  description 'MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.'
  homepage 'http://www.jedsoft.org/most/'
  version '5.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.jedsoft.org/releases/most/most-#{version}.tar.gz"
  source_sha256 '9455aeb8f826fa8385c850dc22bf0f22cf9069b3c3423fba4bf2c6f6226d9903'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_armv7l/most-5.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_armv7l/most-5.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_i686/most-5.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_x86_64/most-5.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6689e97e303c8e6ab015a54dcc518e8f3aaafb67c3d7c4921a1fdebaf112c3c4',
     armv7l: '6689e97e303c8e6ab015a54dcc518e8f3aaafb67c3d7c4921a1fdebaf112c3c4',
       i686: '7cae7bae27f55159d799d83824e00e6a25ec3b2fc4ec8f2c74b5e793e1cc50d6',
     x86_64: 'afc592b6140eb946a257197597f624a5125ae1f694f4883d5013461be388e071'
  })

  depends_on 'glibc' # R
  depends_on 'slang' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
