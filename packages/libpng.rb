require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  @_ver = '1.6.37'
  version "#{@_ver}-2"
  license 'libpng2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/libpng/libpng16/#{@_ver}/libpng-#{@_ver}.tar.xz"
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  depends_on 'shared_mime_info'
  depends_on 'hashpipe' => :build

  def self.patch
    system 'filefix'
    # Patch in APNG support
    system 'curl -#L https://sourceforge.net/projects/apng/files/libpng/libpng16/libpng-1.6.37-apng.patch.gz | \
              hashpipe sha256 10d9e0cb60e2b387a79b355eb7527c0bee2ed8cbd12cf04417cabc4d6976683c | \
              gunzip | \
              patch -Np0'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'update-mime-database', "#{CREW_PREFIX}/share/mime"
  end
end
