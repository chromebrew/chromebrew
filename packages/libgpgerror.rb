require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  @_ver = '1.42'
  version "#{@_ver}-1"
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{@_ver}.tar.bz2"
  source_sha256 'fc07e70f6c615f8c4f590a8e37a9b8dd2e2ca1e9408f8e60459c67452b925e23'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.42-1_armv7l/libgpgerror-1.42-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.42-1_armv7l/libgpgerror-1.42-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.42-1_i686/libgpgerror-1.42-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.42-1_x86_64/libgpgerror-1.42-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '46ca55616094f55ad7a071f06ea9b028d58ab8883407155ef472cf6b8bc105a7',
     armv7l: '46ca55616094f55ad7a071f06ea9b028d58ab8883407155ef472cf6b8bc105a7',
       i686: 'ef29d332a020b339c83492adf00b2aae6173d2a86b4b11922c48338dd73b9138',
     x86_64: '87bdb815ac35effdf3a42e8dad56f947dcd51280590db3e64b59fc744908ce2d'
  })

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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
