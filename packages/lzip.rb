require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.21'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.21.tar.lz'
  source_sha256 '68c703c7b5198b3fd7a0c3f20011e9a8c938b8dec14824c4c873922fdb01719f'

  binary_url ({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/lzip-1.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/lzip-1.21-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/lzip-1.21-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/lzip-1.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '09f94e775a908f77177ee4657940e62e8a223b50210d66b581b4ee823416cac9',
     armv7l: '09f94e775a908f77177ee4657940e62e8a223b50210d66b581b4ee823416cac9',
       i686: '6ec82131cdda0a15c8b78bc5602fdfa84b52336d76b4fd1c70d710e99b9ed3cc',
     x86_64: '3e79f5606033b8dde418900d6957d06b606a9bffb240eb67e7166e38dcdfe699',
  })

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
