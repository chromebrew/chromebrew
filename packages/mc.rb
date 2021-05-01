require 'package'

class Mc < Package
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.26'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/MidnightCommander/mc/archive/#{version}.tar.gz"
  source_sha256 'e585508ee4e0066c13d304e4c7135d7c6140f5c5027e01a024b3a508a6cf8025'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.26_armv7l/mc-4.8.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.26_armv7l/mc-4.8.26-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.26_i686/mc-4.8.26-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.26_x86_64/mc-4.8.26-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0613a92137481949becea8a8780b06db5fd7945184dee96e4866d5faf5336681',
     armv7l: '0613a92137481949becea8a8780b06db5fd7945184dee96e4866d5faf5336681',
       i686: 'c486a081d10adbc367c104f5b1cb9a7ea37cc3609956e6fe6f0b5af444c4a452',
     x86_64: 'de22c3351082961fee8499be803a5bd9261de9de42e8510e9c567c0cbf160bc0'
  })

  depends_on 'glib' => :build
  depends_on 'aspell' => :build
  depends_on 'gpm'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CPPFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
