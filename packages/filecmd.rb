require 'package'

class Filecmd < Package
  description 'file and libmagic determine file type'
  homepage 'http://ftp.astron.com/'
  version '5.44'
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@version}.tar.gz"
  source_sha256 '3751c7fba8dbc831cb8d7cc8aff21035459b8ce5155ef8b0880a27d028475f3b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_armv7l/filecmd-5.44-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_armv7l/filecmd-5.44-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_i686/filecmd-5.44-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_x86_64/filecmd-5.44-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f443367c293f3f88ac2f4c69bd9f9a6422b9554a191bf57596ef5e1399209ffd',
     armv7l: 'f443367c293f3f88ac2f4c69bd9f9a6422b9554a191bf57596ef5e1399209ffd',
       i686: 'e1d75ecf5436d9985e13e8f4be0231accea5cdfbede4e92659814455823ba64e',
     x86_64: '20f661a859cfbc87b0847ed3b98a46d8bc618c05df8e0c08ff4468d8fc403753'
  })

  depends_on 'bz2' # R
  depends_on 'glibc' # R
  depends_on 'lzlib' # R Fixes checking lzlib.h usability... no
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'gcc_lib' # R
  depends_on 'zstd' # R

  def self.prebuild
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    # This may be needed in older autotools tarballs due to an old libtool bug.
    # It's better to run filefix if unsure.
    # See https://savannah.gnu.org/support/?func=detailitem&item_id=110550 for more information.

    @filefix = <<~EOF
      #!/usr/bin/env bash
      while IFS= read -r -d '' f; do
        sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' "${f}"
      done <  <(find . -name configure -print0)
    EOF
    File.write('filefix', @filefix)
  end

  def self.patch
    # Fix Error: /usr/bin/file file not found.
    system 'filefix'
  end

  def self.build
    @filecmd_config_opts = "--enable-static \
                            --enable-shared \
                            --enable-zlib \
                            --enable-bzlib \
                            --enable-xzlib \
                            --enable-fsect-man5 \
                            --disable-libseccomp" # libseccomp is disabled because
                            # it causes file to return "Bad system call" errors when
                            # not run with root.

    # Build a static file binary for use in case needed with glibc brokenness.
    Dir.mkdir 'builddir-static'
    Dir.chdir 'builddir-static' do
      system "env LDFLAGS+=' -static' \
      ../configure \
        #{CREW_OPTIONS} \
        #{@filecmd_config_opts}"
      system 'make'
    end

    # Build libmagic and everything else (dynamically linked).
    Dir.mkdir 'builddir-dynamic'
    Dir.chdir 'builddir-dynamic' do
      system "../configure \
        #{CREW_OPTIONS} \
        #{@filecmd_config_opts}"
      system 'make'
    end
  end

  def self.check
    system 'make -C builddir-static check'
    system 'make -C builddir-dynamic check'
  end

  def self.install
    # Install dynamically linked package.
    system "make -C builddir-dynamic DESTDIR='#{CREW_DEST_DIR}' install"
    # Install statically linked package to local directory and copy binary
    # DESTDIR must be a full path, hence running pwd.
    system "make -C builddir-static DESTDIR='#{Dir.pwd}/dest-static' install"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/file"
    FileUtils.install 'dest-static/usr/local/bin/file', "#{CREW_DEST_PREFIX}/bin/file", mode: 0o755
    # Install filefix.
    FileUtils.install 'filefix', "#{CREW_DEST_PREFIX}/bin/filefix", mode: 0o755
  end
end
