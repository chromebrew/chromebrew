require 'package'

class Filecmd < Package
  description 'file and libmagic determine file type'
  homepage 'http://ftp.astron.com/'
  @_ver = '5.43'
  version @_ver
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@_ver}.tar.gz"
  source_sha256 '8c8015e91ae0e8d0321d94c78239892ef9dbc70c4ade0008c0e95894abfb1991'

  depends_on 'bz2' # R
  depends_on 'glibc' # R
  depends_on 'libseccomp' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  def self.prebuild
    # The filefix command changes the full path of the file command in configure scripts
    # Execute this command from your source code root directory
    # This may be needed in older autotools tarballs due to an old libtool bug
    # It's better to run filefix if unsure
    # See https://savannah.gnu.org/support/?func=detailitem&item_id=110550 for more information

    @filefix = <<~EOF
      #!/usr/bin/env bash
      while IFS= read -r -d '' f; do
        sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' "${f}"
      done <  <(find . -name configure -print0)
    EOF
    File.write('filefix', @filefix)
  end

  @filecmd_config_opts = "--enable-static \
                        --enable-shared \
                        --enable-zlib \
                        --enable-bzlib \
                        --enable-xzlib \
                        --enable-fsect-man5 \
                        --disable-libseccomp" # libseccomp is disabled because
                        # it causes file to return "Bad system call" errors when
                        # not run with root

  def self.build
    # Build a static file binary for use in case needed with glibc brokenness.
    Dir.mkdir 'builddir-static'
    Dir.chdir 'builddir-static' do
      system "env LDFLAGS+=' -static' \
      ../configure \
        #{CREW_OPTIONS} \
        #{@filecmd_config_opts}"
      system 'make'
    end

    # Build libmagic and everything else (dynamically linked)
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
    # Install dynamically linked package
    system "make -C builddir-dynamic DESTDIR='#{CREW_DEST_DIR}' install"
    # Install statically linked package to local directory and copy binary
    # DESTDIR must be a full path, hence running pwd
    system "make -C builddir-static DESTDIR='#{Dir.pwd}/dest-static' install"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/file"
    FileUtils.install 'dest-static/usr/local/bin/file', "#{CREW_DEST_PREFIX}/bin/file", mode: 0o755
    # Install filefix
    FileUtils.install 'filefix', "#{CREW_DEST_PREFIX}/bin/filefix", mode: 0o755
  end
end
