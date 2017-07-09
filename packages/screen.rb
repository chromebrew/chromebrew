require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.3.1'
  source_url 'ftp://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz'
  source_sha256 'fa4049f8aee283de62e283d427f2cfd35d6c369b40f7f45f947dbfd915699d63'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/screen-4.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/screen-4.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/screen-4.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/screen-4.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '342f4d040d9d0d1532ac1862e3aa6bf78b386f4fd1cce297de35ee8d8dc65d23',
     armv7l: '342f4d040d9d0d1532ac1862e3aa6bf78b386f4fd1cce297de35ee8d8dc65d23',
       i686: 'f43c00ae2d66202beb74c3ee37a34af27ce2366771ac4bdc409fbb2c7eaa76b3',
     x86_64: '62a4903e91d6f85db76293ff41daa03d4250565e3906b267e76d9f5756dc6f95',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
