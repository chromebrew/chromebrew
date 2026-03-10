require 'package'

class Filecmd < Package
  description 'file and libmagic determine file type'
  homepage 'https://darwinsys.com/file/'
  version '5.47'
  license 'BSD-2 and GPL-3+' # Chromebrew's filefix is GPL-3+, file itself is BSD-2
  compatibility 'all'
  source_url 'https://github.com/file/file.git'
  git_hashtag "FILE#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9163715750c6d7e9d70ff081edc97c70b1a717e822787385793708222cc5408e',
     armv7l: '9163715750c6d7e9d70ff081edc97c70b1a717e822787385793708222cc5408e',
       i686: '668763b09dc6d188fb5e0acdad208563718d10a9b28aa543247a663a87356efe',
     x86_64: 'e5fe4216f9fd7d02d4b75f225fa5eb53fc4c6faca7df95416e27689136054470'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'lzlib' # R Fixes checking lzlib.h usability... no
  depends_on 'xzutils' # R
  depends_on 'zstd' # R

  def self.prebuild
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    # This may be needed in older autotools tarballs due to an old libtool bug.
    # It's better to run filefix if unsure.
    # See https://savannah.gnu.org/support/?func=detailitem&item_id=110550 for more information.

    File.write 'filefix', <<~FILEFIX_EOF
      #!/usr/bin/env bash
      # Fix Error: /usr/bin/file file not found.
      echo "filefix: Checking for scripts using: '/usr/bin/file' ..."
      while IFS= read -r -d '' f; do
        sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' "${f}"
      done <  <(find . -name configure -print0)
      # Make sure we are using the Chromebrew bash shell instead of
      # /bin/sh which in ChromeOS is actually dash.
      echo "filefix: Checking for scripts using: '/bin/sh ' ..."
      grep -rlZ '/bin/sh ' . | xargs -r -0 sed -i 's,/bin/sh ,#{CREW_PREFIX}/bin/sh ,g'
      echo "filefix: Checking for scripts using: '/bin/sh \\\"' ..."
      grep -rlZ "/bin/sh\\\"" . | xargs -r -0 sed -i 's,/bin/sh",#{CREW_PREFIX}/bin/sh",g'
      echo "filefix: Checking for scripts using: \\\"'/bin/sh '\\\" ..."
      grep -rlZ "/bin/sh\\\'" . | xargs -r -0 sed -i "s,/bin/sh',#{CREW_PREFIX}/bin/sh',g"
    FILEFIX_EOF
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
                            --disable-libseccomp" # libseccomp is disabled because it causes file to return "Bad system call" errors when not run with root.

    # Build a static file binary for use in case needed with glibc brokenness.
    Dir.mkdir 'builddir-static'
    Dir.chdir 'builddir-static' do
      system "env LDFLAGS+=' -static' \
      ../configure \
        #{CREW_CONFIGURE_OPTIONS} \
        #{@filecmd_config_opts}"
      system 'make'
    end

    # Build libmagic and everything else (dynamically linked).
    Dir.mkdir 'builddir-dynamic'
    Dir.chdir 'builddir-dynamic' do
      system "../configure \
        #{CREW_CONFIGURE_OPTIONS} \
        #{@filecmd_config_opts}"
      system 'make'
    end
  end

  def self.check
    system 'make -C builddir-static check || true'
    system 'make -C builddir-dynamic check || true'
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
