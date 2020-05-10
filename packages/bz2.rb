require 'package'

class Bz2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.8'
  compatibility 'all'
  source_url 'https://fossies.org/linux/misc/bzip2-1.0.8.tar.gz'
  source_sha256 'ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '11fbd7bb0897446cfda34be28db698ecdcbfbcb70e23311fe405edf1aa9abec4',
     armv7l: '11fbd7bb0897446cfda34be28db698ecdcbfbcb70e23311fe405edf1aa9abec4',
       i686: '82f0c8f531c14cef34d9b2a7b1c3a8f1783d43fad87a3da19a12da91abf03857',
     x86_64: '418cff679b9753a9f247a77bf0d61994fc73ee473e6eaed49cd8aa4a159166a7',
  })

  def self.build
    system "make -f Makefile-libbz2_so"
  end

  def self.install
    # bz2 Makefile doesn't have DESTDIR, so we need several tricks
    # to make it install files correctly.

    # Modify Makefile from "ln -s $(PREFIX)/bin/xxx $(PREFIX)/bin/yyy" to
    # "ln -s xxx $(PREFIX)/bin/yyy"
    system "sed -i Makefile -e '/ln -s/s:$(PREFIX)/bin/::'"

    # Use PREFIX instead of DESTDIR
    system "make", "PREFIX=#{CREW_DEST_PREFIX}", "install"

    # Remove static library
    system "rm #{CREW_DEST_PREFIX}/lib/libbz2.a"

    # Install bzip2 using shared library by hand
    system "cp -p bzip2-shared bzip2"
    system "install -Dm755 bzip2 #{CREW_DEST_PREFIX}/bin/bzip2"
    system "ln -sf bzip2 #{CREW_DEST_PREFIX}/bin/bunzip2"
    system "ln -sf bzip2 #{CREW_DEST_PREFIX}/bin/bzcat"

    # Install shared library by hand
    system "install -Dm644 libbz2.so.1.0.8 #{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0.8"
    system "ln -s libbz2.so.1.0.8 #{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0"
    system "ln -s libbz2.so.1.0.8 #{CREW_DEST_LIB_PREFIX}/libbz2.so.1"
    system "ln -s libbz2.so.1.0.8 #{CREW_DEST_LIB_PREFIX}/libbz2.so"

    # Move manpages
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share")
    system "mv #{CREW_DEST_PREFIX}/man #{CREW_DEST_PREFIX}/share/"
  end

  def self.check
    system "make", "test"
  end
end
