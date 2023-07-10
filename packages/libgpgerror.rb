require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.47'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  source_sha256 '9e3c670966b96ecc746c28c2c419541e3bcb787d1a73930f5e5f5e1bcbbb9bdb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.47_armv7l/libgpgerror-1.47-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.47_armv7l/libgpgerror-1.47-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.47_i686/libgpgerror-1.47-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.47_x86_64/libgpgerror-1.47-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '38dd7c36e96e78bcd9b2ec5ef6c2e1780d6b5f30f0855c71ffd78c6e0fedef1a',
     armv7l: '38dd7c36e96e78bcd9b2ec5ef6c2e1780d6b5f30f0855c71ffd78c6e0fedef1a',
       i686: 'fa9cf1ebe679e6b8cac9beae0621c7da4f47f9f4378fde278ca1b666493cd7fe',
     x86_64: '5f7a17c69ddb9c23cc76f3a2c52d0874c74c4b876c66bb710036c6accbbdd27a'
  })

  depends_on 'gcc_lib' # R
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
