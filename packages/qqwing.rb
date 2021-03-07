require 'package'

class Qqwing < Package
  description 'QQwing is a Sudoku puzzle generator and solver.'
  homepage 'https://qqwing.com/'
  @_ver = '1.3.4'
  version @_ver
  source_url "https://github.com/stephenostermiller/qqwing/archive/v#{@_ver}.tar.gz"
  source_sha256 'dc5d61b4470862b190d437f8143d4090639c164d34461c4caa5c081c5c91e6cc'
  
  depends_on 'perl' => :build

  def self.patch
    system 'sed -i s:/bin/sh:/bin/bash:g build/src-copyright-fix.sh'
    system 'sed -i s:/usr/bin/perl:/usr/local/bin/perl:g build/src-first-comment.pl'
    FileUtils.install '/dev/null', 'build/src_neaten.pl', mode: 0755
  end
    
  def self.build
    system 'make', "prefix=#{CREW_PREFIX}", 'tgz'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    if Dir.exist?("#{CREW_PREFIX}/lib64") then
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/lib/libqqwing.so", "#{CREW_DEST_LIB_PREFIX}/libqqwing.so"
      FileUtils.ln_s "#{CREW_PREFIX}/lib/libqqwing.so", "#{CREW_DEST_LIB_PREFIX}/libqqwing.so.2"
      FileUtils.ln_s "#{CREW_PREFIX}/lib/libqqwing.so", "#{CREW_DEST_LIB_PREFIX}/libqqwing.so.2.1.0"
    end
  end

  def self.check
    system "make", "check"
  end
    
  def self.remove
    # since qqwing doesn't fully support custom prefix and DESTDIR, we need to remove them manually
    FileUtils.rm_rf Dir.glob("#{CREW_PREFIX}/lib/libqqwing.*")
  end
end
