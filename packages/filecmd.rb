require 'package'

class Filecmd < Package
  description 'file and libmagic determine file type'
  homepage 'http://ftp.astron.com/'
  @_ver = '5.44'
  version @_ver
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url "http://ftp.astron.com/pub/file/file-#{@_ver}.tar.gz"
  source_sha256 '3751c7fba8dbc831cb8d7cc8aff21035459b8ce5155ef8b0880a27d028475f3b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_armv7l/filecmd-5.44-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_armv7l/filecmd-5.44-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_i686/filecmd-5.44-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filecmd/5.44_x86_64/filecmd-5.44-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c7d721a6469958acd6ce8a33ad1d57fb35a7e33a1fa128f43ea4531c36f9777a',
     armv7l: 'c7d721a6469958acd6ce8a33ad1d57fb35a7e33a1fa128f43ea4531c36f9777a',
       i686: 'a8f4e4346ee62ad74187d9cef0304315e8eb8c836434942475f0395eeacf6f11',
     x86_64: '72367d1a858b4e8848207e93a3a4121cfac5ebb6dbe38466af1a73366a4c9d03'
  })

  depends_on 'bz2' # R
  depends_on 'glibc' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'gcc' # R
  depends_on 'zstd' # R

  # The file command is used inside the strip_dir code block in crew.
  no_strip

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
                        --disable-libseccomp"
                        # libseccomp is disabled because
                        # it causes file to return "Bad system call" errors when
                        # not run as root.

  def self.build
    # This tarball was built with a buggy version of libtool. This shouldn't be the case for file 5.44
    system 'filefix'

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
