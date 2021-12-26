require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  @_ver = '1.43'
  version "#{@_ver}-1"
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{@_ver}.tar.bz2"
  source_sha256 'a9ab83ca7acc442a5bd846a75b920285ff79bdb4e3d34aa382be88ed2c3aebaf'

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
