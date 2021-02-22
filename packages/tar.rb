require 'package'

class Tar < Package
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.33'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/tar/tar-1.33.tar.xz'
  source_sha256 '66a8344b1dc83a411d311bd1547e0176e56cc311f28ee94a30f84dafb3d9067e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tar-1.33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tar-1.33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tar-1.33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tar-1.33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd5441f72cb619faf1d1c105adee8ad262fbdaeb2f74126042af03c8621c879c9',
     armv7l: 'd5441f72cb619faf1d1c105adee8ad262fbdaeb2f74126042af03c8621c879c9',
       i686: 'a75a93e8743077b580220105e54e47c9ba19e6028a0124b43f4023f5f3118b49',
     x86_64: '899d437a76bbc5dba88b1686671d492624d17bb6e9c9c9808fe54c9bee22c078',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --with-lzma=xz"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
