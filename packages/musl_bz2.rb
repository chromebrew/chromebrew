require 'package'

class Musl_bz2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.8'
  license 'BZIP2'
  compatibility 'all'
  source_url 'https://fossies.org/linux/misc/bzip2-1.0.8.tar.gz'
  source_sha256 'ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '45641ed96b6d391c9835fba0a8e567da398c764b49b3ca2ad0acdffc81c18b5c',
     armv7l: '45641ed96b6d391c9835fba0a8e567da398c764b49b3ca2ad0acdffc81c18b5c',
       i686: 'abdce567d02a946581afc4ab6122fc3e21221c92e273841b83b988f0667f996e',
     x86_64: '0491dda97107a65317cf6a6896d11654159623ed8f6107efdaafa710326723fe'
  })

  depends_on 'patchelf' => :build

  def self.patch
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    # Modify Makefile from "ln -s $(PREFIX)/bin/xxx $(PREFIX)/bin/yyy" to
    # "ln -s xxx $(PREFIX)/bin/yyy"
    system "sed -i Makefile -e '/ln -s/s:$(PREFIX)/bin/::'"
    system "sed -i 's,gcc,#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc #{MUSL_CFLAGS},g' Makefile"
    system "sed -i 's,CFLAGS=-fpic,CFLAGS=-fpic #{MUSL_CFLAGS},g' Makefile"
    system "sed -i 's,gcc,#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc,g' Makefile-libbz2_so"
    system "sed -i 's|CFLAGS=-fpic|CFLAGS=-fpic #{MUSL_CFLAGS}|g' Makefile-libbz2_so"
    system "sed -i 's|LDFLAGS=|LDFLAGS=\"#{MUSL_LDFLAGS}\"|g' Makefile"
    system "sed -i 's|LDFLAGS=|LDFLAGS=\"#{MUSL_LDFLAGS}\"|g' Makefile-libbz2_so"
    # Test expects ./bzip2, which is created in install section.
    FileUtils.cp 'Makefile', 'Makefile.test'
    system "sed -i 's,./bzip2 ,./bzip2-shared ,g' Makefile.test"
  end

  def self.build
    system 'make -f Makefile-libbz2_so all'
  end

  def self.check
    system 'make -f Makefile.test test'
  end

  def self.install
    # bz2 Makefile doesn't have DESTDIR, so we need several tricks
    # to make it install files correctly.

    # Use PREFIX instead of DESTDIR
    system 'make', "PREFIX=#{CREW_DEST_MUSL_PREFIX}", 'install'

    # Install bzip2 using shared library by hand
    system 'cp -p bzip2-shared bzip2'
    # Set musl interpreter for binaries
    %w[bzip2-shared].each do |f|
      system "patchelf --set-interpreter #{CREW_MUSL_PREFIX}/lib/libc.so #{f}"
    end
    system "install -Dm755 bzip2 #{CREW_DEST_MUSL_PREFIX}/bin/bzip2"
    system "ln -sf bzip2 #{CREW_DEST_MUSL_PREFIX}/bin/bunzip2"
    system "ln -sf bzip2 #{CREW_DEST_MUSL_PREFIX}/bin/bzcat"

    # Install shared library by hand
    system "install -Dm644 libbz2.so.1.0.8 #{CREW_DEST_MUSL_PREFIX}/libbz2.so.1.0.8"
    system "ln -s libbz2.so.1.0.8 #{CREW_DEST_MUSL_PREFIX}/libbz2.so.1.0"
    system "ln -s libbz2.so.1.0.8 #{CREW_DEST_MUSL_PREFIX}/libbz2.so.1"
    system "ln -s libbz2.so.1.0.8 #{CREW_DEST_MUSL_PREFIX}/libbz2.so"

    # Move manpages
    FileUtils.mkdir_p("#{CREW_DEST_MUSL_PREFIX}/share")
    system "mv #{CREW_DEST_MUSL_PREFIX}/man #{CREW_DEST_MUSL_PREFIX}/share/"
  end
end
