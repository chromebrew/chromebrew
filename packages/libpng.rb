require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library. Patched with APNG support.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  @_ver = '1.6.37'
  version "#{@_ver}-3"
  license 'libpng2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/libpng/libpng16/#{@_ver}/libpng-#{@_ver}.tar.xz"
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37-3_armv7l/libpng-1.6.37-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37-3_armv7l/libpng-1.6.37-3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37-3_i686/libpng-1.6.37-3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37-1_x86_64/libpng-1.6.37-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '267f2ef6f7261612350b576acadbfa258471122365a68c1f81bf5785b65631d0',
     armv7l: '267f2ef6f7261612350b576acadbfa258471122365a68c1f81bf5785b65631d0',
       i686: '39cb6b94600b6fa4619941ddacc42972d176aa9ac8e2372bdaf469644c2caf35',
     x86_64: 'bd8a6e366fbb60cdb86dcd88660ecb44bbee44c8087802a789b720b59ab43db2',
  })

  depends_on 'shared_mime_info'

  def self.patch
    system 'filefix'
    # patch in APNG (animated PNG) support
    system "curl -#LO https://sourceforge.net/projects/apng/files/libpng/libpng16/libpng-#{@_ver}-apng.patch.gz"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("libpng-#{@_ver}-apng.patch.gz") ) == '10d9e0cb60e2b387a79b355eb7527c0bee2ed8cbd12cf04417cabc4d6976683c'
    system "gunzip libpng-#{@_ver}-apng.patch.gz"
    system "patch -Np0 -i libpng-#{@_ver}-apng.patch"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'update-mime-database', "#{CREW_PREFIX}/share/mime"
  end
end
