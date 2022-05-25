require 'package'

class Bzip2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.8-2'
  license 'BZIP2'
  compatibility 'all'
  source_url 'https://fossies.org/linux/misc/bzip2-1.0.8.tar.gz'
  source_sha256 'ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip2/1.0.8-2_armv7l/bzip2-1.0.8-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip2/1.0.8-2_armv7l/bzip2-1.0.8-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip2/1.0.8-2_i686/bzip2-1.0.8-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip2/1.0.8-2_x86_64/bzip2-1.0.8-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5e4818a8ab4fbb31e0205cbf9fa8f919af3ab2216093a9c5c15416620d24089c',
     armv7l: '5e4818a8ab4fbb31e0205cbf9fa8f919af3ab2216093a9c5c15416620d24089c',
       i686: 'e7b6d78ceb1def87c943ba95dd1dfa0463304373ae07a1d23e5350216f47ae39',
     x86_64: '34ba6b40cb97ba231f526e9336a949457698f647273b2883d2ead8cd3a07beae'
  })

  depends_on 'gcc_lib' # R
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
