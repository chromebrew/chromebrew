require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'http://ftp.astron.com/pub/file'
  version '5.39'
  compatibility 'all'
  source_url 'http://ftp.astron.com/pub/file/file-5.39.tar.gz'
  source_sha256 'f05d286a76d9556243d0cb05814929c2ecf3a5ba07963f8f70bfaaa70517fad1'

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
    system "make DESTDIR=#{CREW_DEST_DIR} install-strip | sed -e s/'libtool: warning: remember to run \'libtool --finish /usr/local/lib64\'//g'"
  end
  def self.postinstall
    system "libtool --finish #{CREW_LIB_PREFIX}"
  end
end
