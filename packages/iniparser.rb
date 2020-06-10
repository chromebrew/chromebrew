require 'package'

class Iniparser < Package
  description 'stand-alone ini parser library in ANSI C'
  homepage 'http://ndevilla.free.fr/iniparser/'
  version '4.1'
  compatibility 'all'
  source_url 'https://github.com/ndevilla/iniparser/archive/v4.1.tar.gz'
  source_sha256 '960daa800dd31d70ba1bacf3ea2d22e8ddfc2906534bf328319495966443f3ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iniparser-4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iniparser-4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iniparser-4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iniparser-4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '712e6e63ea2aa696666a53ba354a5108f158241ce806f1eda5b27a577cc7bd58',
     armv7l: '712e6e63ea2aa696666a53ba354a5108f158241ce806f1eda5b27a577cc7bd58',
       i686: 'e48a36dd2464e406f43e301bcee25592b225f7eb7a7ab90bbfbfa2ea19c2ad86',
     x86_64: '9a00066ad86da206832d1c9c024fa83e0cb0da923332581342a32dcc748254dd',
  })

  def self.patch
    # Fix buffer overflow vulnerabilities
    system 'wget', 'https://github.com/ndevilla/iniparser/commit/a249509544972d60f5077bfde554af480bd82594.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('a249509544972d60f5077bfde554af480bd82594.patch') ) == '1b1fe5d2faf6eb5bed51b80b046d4699c09b14b3e5e5277aed790a8741fcad8b'
    system 'patch', '-Np1', '-i', 'a249509544972d60f5077bfde554af480bd82594.patch'
    # Fix libdir
    system 'sed', '-i', "s,/usr/lib,#{CREW_LIB_PREFIX},g", 'Makefile'
  end

  def self.build
    system 'make'
  end

  def self.install
    # Create needed directories
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p CREW_DEST_PREFIX + '/include'
    # Install library
    FileUtils.install 'libiniparser.so.1', CREW_DEST_LIB_PREFIX
    # Install header files
    FileUtils.install Dir.glob('src/*.h'), CREW_DEST_PREFIX + '/include'
    # Install library symlink
    FileUtils.ln_s 'libiniparser.so.1', CREW_DEST_LIB_PREFIX + '/libiniparser.so'
  end

  def self.check
    system 'make', 'check'
  end
end
