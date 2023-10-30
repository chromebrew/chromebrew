require 'package'

class Bzip2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.8-1'
  license 'BZIP2'
  compatibility 'all'
  source_url 'https://fossies.org/linux/misc/bzip2-1.0.8.tar.gz'
  source_sha256 'ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz2/1.0.8-1_armv7l/bz2-1.0.8-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz2/1.0.8-1_armv7l/bz2-1.0.8-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz2/1.0.8-1_i686/bz2-1.0.8-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz2/1.0.8-1_x86_64/bz2-1.0.8-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '98fec974c6fda9d4f12988db8eed1338d136fe78866f80047db70fe0bab15bcf',
     armv7l: '98fec974c6fda9d4f12988db8eed1338d136fe78866f80047db70fe0bab15bcf',
       i686: '2beb95c3ec8455c5eda6a4e6be3baa00a5f8ef24c9561f58750758ba62e9cc8e',
     x86_64: 'e5dee3da36d88d602496925888f966d47453d4a52e684c4bc6a982906b3b9f32'
  })

  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's,^LDFLAGS=,LDFLAGS=-flto=auto,' Makefile"
    system "sed -i 's,^CFLAGS=-Wall,CFLAGS=-Wall -flto=auto,' Makefile"
    system "sed -i 's,^CFLAGS=-fpic,CFLAGS=-fpic -flto=auto,' Makefile-libbz2_so"
  end

  def self.build
    system 'make -f Makefile-libbz2_so'
  end

  def self.install
    # bz2 Makefile doesn't have DESTDIR, so we need several tricks
    # to make it install files correctly.
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_LIB_PREFIX}
    ]
    # Modify Makefile from "ln -s $(PREFIX)/bin/xxx $(PREFIX)/bin/yyy" to
    # "ln -s xxx $(PREFIX)/bin/yyy"
    system "sed -i Makefile -e '/ln -s/s:$(PREFIX)/bin/::'"

    # Use PREFIX instead of DESTDIR
    system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/libbz2.a", "#{CREW_DEST_LIB_PREFIX}/libbz2.a" if ARCH == 'x86_64'

    # Install bzip2 using shared library by hand
    FileUtils.install 'bzip2-shared', "#{CREW_DEST_PREFIX}/bin/bzip2", mode: 0o755
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_sf 'bzip2', 'bunzip2'
      FileUtils.ln_sf 'bzip2', 'bzcat'
    end

    # Install shared library by hand
    FileUtils.install 'libbz2.so.1.0.8', "#{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0.8", mode: 0o644
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.ln_s 'libbz2.so.1.0.8', "#{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0"
      FileUtils.ln_s 'libbz2.so.1.0.8', "#{CREW_DEST_LIB_PREFIX}/libbz2.so.1"
      FileUtils.ln_s 'libbz2.so.1.0.8', "#{CREW_DEST_LIB_PREFIX}/libbz2.so"
    end

    # Move manpages
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share")
    FileUtils.mv "#{CREW_DEST_PREFIX}/man", "#{CREW_DEST_PREFIX}/share/"
  end

  def self.check
    system 'make', 'test'
  end
end
