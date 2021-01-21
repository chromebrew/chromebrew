require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'http://ftp.astron.com/'
  @_ver = '5.39'
  version @_ver
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@_ver}.tar.gz"
  source_sha256 'f05d286a76d9556243d0cb05814929c2ecf3a5ba07963f8f70bfaaa70517fad1'
  
  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e87bec0e97e45cdf47a1badf36157c4c11565b2a4da081c653d79a26fb4099f6',
      armv7l: 'e87bec0e97e45cdf47a1badf36157c4c11565b2a4da081c653d79a26fb4099f6',
        i686: '85396091dd796294e2b586036153df826bfa5e7007327779fa8972c828cdc445',
      x86_64: 'a27d190d2032ce8c378b7ee902e9532b6be55498bd4b6e7bb48e65d492239159',
  })

  def self.build
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    system "cat <<'EOF'> filefix
#!/bin/bash
for f in $(find . -name configure); do
  sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' ${f}
done
'EOF'"
    system "./configure \
            #{CREW_OPTIONS} \
            --disable-libseccomp"
    system "make"
  end

  def self.check
    system "make", "check"
  end
  
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install 'filefix', "#{CREW_DEST_PREFIX}/bin/filefix", mode: 0755
    system "make DESTDIR=#{CREW_DEST_DIR} install-strip | sed -e \"s,libtool: warning: remember to run 'libtool --finish #{CREW_LIB_PREFIX}',,g\""
  end
  
  def self.postinstall
    system "libtool --finish #{CREW_LIB_PREFIX}"
  end
end
