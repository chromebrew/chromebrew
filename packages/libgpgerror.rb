require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  @_ver = '1.46'
  version @_ver
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{@_ver}.tar.bz2"
  source_sha256 'b7e11a64246bbe5ef37748de43b245abd72cfcd53c9ae5e7fc5ca59f1c81268d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.46_armv7l/libgpgerror-1.46-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.46_armv7l/libgpgerror-1.46-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.46_i686/libgpgerror-1.46-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.46_x86_64/libgpgerror-1.46-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '30acb7df73652eecbffc39395ae756d5bd261d0083c7dcc739b5414eecc6fdf9',
     armv7l: '30acb7df73652eecbffc39395ae756d5bd261d0083c7dcc739b5414eecc6fdf9',
       i686: '21ae511d029d3188fb5ee0ddba53e59b5c316779baa11ac1148f67c9852251a3',
     x86_64: 'fbe9c08c8bdca35261e41dcebe92f0f8f0ba0b83a48a6aa7c2ba9a862a26341b'
  })

  depends_on 'glibc' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS} \
      --enable-static \
      --enable-shared \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.check
    Dir.chdir 'tests' do
      system 'make check'
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
