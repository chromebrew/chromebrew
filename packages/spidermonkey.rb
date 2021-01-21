require 'package'

class Spidermonkey < Package
  description 'SpiderMonkey is Mozilla\'s JavaScript engine written in C and C++.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey'
  version '84.0'
  compatibility 'all'
  source_url 'https://archive.mozilla.org/pub/firefox/releases/84.0/source/firefox-84.0.source.tar.xz'
  source_sha256 '23273ef0165b243f5d0908c38e7854d38070282c9b526e8d93b7503cd5f69138'

  depends_on 'yasm' => :build
  depends_on 'rust' => :build
  
  def self.prebuild
    puts
    puts "Building spidermonkey requires at least 6.4 GB of space available on /mnt/stateful_partition.".lightblue
    puts "It WILL fail without this space. Press Ctrl + C to cancel.".lightblue
    puts
    sleep(5)
  end
 
  def self.build
    ENV['LC_ALL'] = 'C' # https://bugs.gentoo.org/746215
    ENV['MACH_USE_SYSTEM_PYTHON'] = "#{CREW_PREFIX}/bin/python3"
    ENV['CC'] = 'gcc' # Defaults to clang, but configure.py complains about oudated libstdc++ when using clang
    ENV['CXX'] = 'g++'
    ENV['AR'] = 'ar'
    ENV['AS'] = 'as'
    ENV['RANLIB'] = 'ranlib'
    ENV['NM'] = 'nm'
    Dir.chdir 'build' do
      system "#{CREW_PREFIX}/bin/python3 \
            ../configure.py --prefix=#{CREW_DEST_PREFIX} \
            --libdir=#{CREW_DEST_LIB_PREFIX} \
            --host=#{CREW_BUILD} \
            --target=#{CREW_BUILD} \
            --enable-application=js \
            --enable-release \
            --enable-optimize \
            --enable-gold \
            --with-intl-api \
            --with-system-icu \
            --enable-jit \
            --enable-strip" # Mozilla's configure.py doesn't recognize --mandir and --build
      system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
