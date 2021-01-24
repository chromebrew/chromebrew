require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'http://ftp.astron.com/'
  @_ver = '5.39'
  version @_ver + '-1'
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@_ver}.tar.gz"
  source_sha256 'f05d286a76d9556243d0cb05814929c2ecf3a5ba07963f8f70bfaaa70517fad1'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.39-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c0d283e387ec473848a4579b179b782655939b387d0cd9d1bc6cc31950789a54',
      armv7l: 'c0d283e387ec473848a4579b179b782655939b387d0cd9d1bc6cc31950789a54',
        i686: 'c334e68306183ffd5973daf76c153dfc77c61391d2fe9603cc23cf797437db10',
      x86_64: 'c49d511d3074640b6014cb0709c83d9bad021992d775473282644942cd972546',
  })

  def self.build
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    system "cat <<'EOF'> filefix
#!/bin/bash
for f in $(find . -name configure); do
  sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' ${f}
done
EOF"
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
  end
end
