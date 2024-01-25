require 'package'

class Filecmd < Package
  description 'file and libmagic determine file type'
  homepage 'https://www.darwinsys.com/file/'
  version '5.45-8dc5513'
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url 'https://github.com/file/file.git'
  git_hashtag '8dc5513908381a14981b16a85d59ba054bf4df52'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50f314a3a9e88f216c06d9aa5b89c77132539473a1b3bb063704662aa0e9b16c',
     armv7l: '50f314a3a9e88f216c06d9aa5b89c77132539473a1b3bb063704662aa0e9b16c',
       i686: '7ee65126f670cff57931f6def9546cf77b0e476a1f5c43eaa22236abf85d0a37',
     x86_64: '934e22a6546df52a0fba66589029a87d1e4fabefb5a32fd4326615670deb8631'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lzlib' # R Fixes checking lzlib.h usability... no
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.prebuild
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    # This may be needed in older autotools tarballs due to an old libtool bug.
    # It's better to run filefix if unsure.
    # See https://savannah.gnu.org/support/?func=detailitem&item_id=110550 for more information.

    @filefix = <<~FILEFIX_EOF
      #!/usr/bin/env bash
      while IFS= read -r -d '' f; do
        sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' "${f}"
      done <  <(find . -name configure -print0)
    FILEFIX_EOF
    File.write('filefix', @filefix)
  end

  def self.patch
    # Fix Error: /usr/bin/file file not found.
    system 'filefix'
  end

  def self.build
    system 'autoreconf -fiv' unless File.executable? './configure'
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
