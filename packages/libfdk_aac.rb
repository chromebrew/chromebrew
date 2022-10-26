require 'package'

class Libfdk_aac < Package
  description 'Modified library of Fraunhofer AAC decoder and encoder.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '2.0.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.2.tar.gz'
  source_sha256 'c9e8630cf9d433f3cead74906a1520d2223f89bcd3fa9254861017440b8eb22f'

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
