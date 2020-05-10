require 'package'

class Aspell_es < Package
  description 'Spanish Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '1.11-2'
  compatibility 'all'
  source_url 'ftp://ftp.gnu.org/gnu/aspell/dict/es/aspell6-es-1.11-2.tar.bz2'
  source_sha256 'ad367fa1e7069c72eb7ae37e4d39c30a44d32a6aa73cedccbd0d06a69018afcc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_es-1.11-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_es-1.11-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_es-1.11-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_es-1.11-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6672aed4511fc5297e905cfdb10c8491d4e077f53cd0d6eb7500d380f6f7e28d',
     armv7l: '6672aed4511fc5297e905cfdb10c8491d4e077f53cd0d6eb7500d380f6f7e28d',
       i686: 'e6cc8bf92d0f592d98d82f3dd65459e5daee9d032114a902965ba7992909151b',
     x86_64: '378beb1b7c53816d15dffccdfdbc876d56ee4ef37397da065aa2a4275defc991',
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
