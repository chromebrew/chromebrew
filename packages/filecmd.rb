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
     aarch64: 'cdd5e95dfa839a179e68822683a0eda74e83b0ec530fdf82665051ced048d3e7',
      armv7l: 'cdd5e95dfa839a179e68822683a0eda74e83b0ec530fdf82665051ced048d3e7',
        i686: 'af07c76f343f22825915ffae3ec48a1e2542b1df43555363c5d7c0ccb10e3f95',
      x86_64: '25591cd681ad7835f0b5033c0a3e10c23a4bb0a8a1d399ead603f80c743643cb',
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
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure \
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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
