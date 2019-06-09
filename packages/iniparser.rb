require 'package'

class Iniparser < Package
  description 'stand-alone ini parser library in ANSI C'
  homepage 'http://ndevilla.free.fr/iniparser/'
  version '4.1'
  source_url 'https://github.com/ndevilla/iniparser/archive/v4.1.tar.gz'
  source_sha256 '960daa800dd31d70ba1bacf3ea2d22e8ddfc2906534bf328319495966443f3ae'

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
