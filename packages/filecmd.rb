require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'http://ftp.astron.com/'
  @_ver = '5.40'
  version @_ver + '-1'
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@_ver}.tar.gz"
  source_sha256 '167321f43c148a553f68a0ea7f579821ef3b11c27b8cbe158e4df897e4a5dd57'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-1_armv7l/filecmd-5.40-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-1_armv7l/filecmd-5.40-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-1_i686/filecmd-5.40-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-1_x86_64/filecmd-5.40-1-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: 'cd6ac82d2b20553e35041c62bfeb876af2f3eecef89c5b959168b0ce3a315fcd',
     armv7l: 'cd6ac82d2b20553e35041c62bfeb876af2f3eecef89c5b959168b0ce3a315fcd',
       i686: '61f026a550efebbd9629391450548c34bcc5c844bc774eec66f29a085a866bc5',
     x86_64: '796e17e8f971bf5fa4378c43cc7a4e5b88436b48f6b4bca0179a83ba7d36a4c7',
  })

  def self.build
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    @filefix = <<~EOF
      #!/bin/bash
      for f in $(find . -name configure); do
        sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' ${f}
      done
    EOF
    IO.write('./filefix', @filefix)
    # Optimization flags from https://github.com/InBetweenNames/gentooLTO
    # Build static for use in case needed with glibc brokenness.
    system "env  CFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
      CXXFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --enable-static \
      --disable-libseccomp"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install 'filefix', "#{CREW_DEST_PREFIX}/bin/filefix", mode: 0o755
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
