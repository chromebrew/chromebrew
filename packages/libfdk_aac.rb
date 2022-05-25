require 'package'

class Libfdk_aac < Package
  description 'Modified library of Fraunhofer AAC decoder and encoder.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '2.0.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.2.tar.gz'
  source_sha256 'c9e8630cf9d433f3cead74906a1520d2223f89bcd3fa9254861017440b8eb22f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfdk_aac/2.0.2_armv7l/libfdk_aac-2.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfdk_aac/2.0.2_armv7l/libfdk_aac-2.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfdk_aac/2.0.2_i686/libfdk_aac-2.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfdk_aac/2.0.2_x86_64/libfdk_aac-2.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '38d931831284f8959672a481ea184c047a98a9c69d5e3b4e53cc5bacd35162c2',
     armv7l: '38d931831284f8959672a481ea184c047a98a9c69d5e3b4e53cc5bacd35162c2',
       i686: 'a144a32f73459e7f6bc56d8d7cef830d969c5ca02653dbabe3a8d95758a781de',
     x86_64: '80770ebc52857780cab250aadcf19f8845b86331466a519552820d4e35a0ab44'
  })

  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
