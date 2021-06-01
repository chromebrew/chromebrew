require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'http://ftp.astron.com/'
  @_ver = '5.40'
  version "#{@_ver}-2"
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@_ver}.tar.gz"
  source_sha256 '167321f43c148a553f68a0ea7f579821ef3b11c27b8cbe158e4df897e4a5dd57'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-2_armv7l/filecmd-5.40-2-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-2_armv7l/filecmd-5.40-2-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-2_i686/filecmd-5.40-2-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.40-2_x86_64/filecmd-5.40-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '651c9ebb6b6294969df3f776b49fdb3eb08371a7ab8eb929a8e2c8d298e9d6bd',
    armv7l: '651c9ebb6b6294969df3f776b49fdb3eb08371a7ab8eb929a8e2c8d298e9d6bd',
    i686: 'ea5a96dbdf900f836b1ca69eefa72b2622722a1f3d0e46736932cc75b12a653f',
    x86_64: '4d0da2febbb0f5a9e5d08dfe2026a9816aa2b1fb603d2c9328082e740a96c8a2'
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
      LDFLAGS='-flto=auto -static' \
      ./configure \
      #{CREW_OPTIONS} \
      --enable-static \
      --enable-shared \
      --disable-libseccomp"
    system 'make'
    FileUtils.mv 'src/file', 'file.static'
    system "env  CFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
      CXXFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --enable-static \
      --enable-shared \
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
    FileUtils.cp 'file.static', "#{CREW_DEST_PREFIX}/bin/file"
  end
end
