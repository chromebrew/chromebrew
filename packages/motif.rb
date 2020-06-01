require 'package'

class Motif < Package
  description 'Motif is a freely available source code distribution for the Motif user interface component toolkit.'
  homepage 'https://motif.ics.com/'
  version '2.3.8'
  source_url 'https://downloads.sourceforge.net/project/motif/Motif%202.3.8%20Source%20Code/motif-2.3.8.tar.gz'
  source_sha256 '859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/motif-2.3.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/motif-2.3.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/motif-2.3.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/motif-2.3.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1c54520d4eaf0c6f9731aa486d63df65b6f0b32edef3eff2184dc6b699851b42',
     armv7l: '1c54520d4eaf0c6f9731aa486d63df65b6f0b32edef3eff2184dc6b699851b42',
       i686: '6ff165d03c99b80835f8e115712bcd54538c6a3024481e88cc8419043e3d070c',
     x86_64: '2eb3c2761fdae830ecf8ab30b406de48a566112e635d63456d802da5ff012081',
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-x --enable-xft --enable-png --enable-jpeg"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

