require 'package'

class Js78 < Package
  description 'JavaScript interpreter and libraries - Version 78'
  @_ver = '78.7.0'
  version @_ver
  compatibility 'all'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{@_ver}esr/source/firefox-#{@_ver}esr.source.tar.xz"
  source_sha256 '1aa041db28cd742e93d663a9da8defd33040b38d8b9470350538473251621643'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/js78-78.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/js78-78.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/js78-78.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/js78-78.7.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bf8e6afa9277745bad6e9d4f16f86e4b5bb41357ef502c9776968d0a4ecbe008',
     armv7l: 'bf8e6afa9277745bad6e9d4f16f86e4b5bb41357ef502c9776968d0a4ecbe008',
       i686: '68e098b895ecd069ed0f2eb0fec321a03caded6cbc426daec7d2e63e8572f2e3',
     x86_64: '4cb92c9bd6d44208816cf8bbfb6504795766544a509e06ee2f792a8c44d99beb'
  })

  depends_on 'autoconf213' => ':build'
  depends_on 'rust' => ':build'
  depends_on 'llvm'
  depends_on 'nspr'

  case ARCH
  when 'aarch64', 'armv7l'
    @rust_default_host = 'armv7-unknown-linux-gnueabihf'
  else
    @rust_default_host = "#{ARCH}-unknown-linux-gnu"
  end

  def self.patch
    # Ubuntu patches
    # http://changelogs.ubuntu.com/changelogs/pool/main/m/mozjs78/mozjs78_78.4.0-2/changelog
    patch_url = 'http://archive.ubuntu.com/ubuntu/pool/main/m/mozjs78/mozjs78_78.4.0-2.debian.tar.xz'
    patch_sha256 = 'dcf2eec86c275448656cf18b3c142c3a2067dc8fdeff029211b66182b9179d21'

    system('wget', '--continue', '--no-check-certificate', patch_url, '-O', 'unzippatches.tar.xz')
    unless Digest::SHA256.hexdigest(File.read('./unzippatches.tar.xz')) == patch_sha256
      abort 'Checksum mismatch :/ try again'
    end
    system('tar', '-xf', 'unzippatches.tar.xz')

    system('for i in `cat debian/patches/series`; do  patch -p 1 < debian/patches/$i; done')

    # Arch Patches
    patch2_url = 'https://github.com/archlinux/svntogit-packages/raw/packages/js78/trunk/0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch'
    patch2_sha256 = 'ad3dd149651d76c1c3de2dc71d3fb3361181a1add75ff095df7bfba88a4e4ad6'
    system('curl', '-Lf', patch2_url, '-o', '0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch')
    unless Digest::SHA256.hexdigest(File.read('./0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch')) == patch2_sha256
      abort 'Checksum mismatch :/ try again'
    end
    system('patch -p 1 < ./0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch')
  end

  def self.build
    FileUtils.mkdir_p 'obj'
    Dir.chdir 'obj' do
      system '../js/src/configure --help'
      system "env CFLAGS='-stdlib=libc++ -flto=thin' \
            RUSTFLAGS='-Clinker-plugin-lto' \
            CXXFLAGS='-I#{CREW_PREFIX}/include/c++/v1/ -flto=thin'
            CXX='clang++ -stdlib=libc++ -I#{CREW_PREFIX}/include/c++/v1/ -flto=thin' \
            AR=llvm-ar NM=llvm-nm RANLIB=llvm-ranlib \
            LDFLAGS='-lreadline -ltinfo -flto=thin' \
            ../js/src/configure --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-debug \
            --disable-debug-symbols \
            --disable-jemalloc \
            --disable-strip \
            --enable-hardening \
            --enable-linker=lld \
            --enable-optimize \
            --enable-release \
            --enable-lto \
            --enable-shared-js \
            --with-intl-api \
            --with-system-zlib \
            --without-system-icu \
            --enable-rust-simd \
            --with-system-nspr"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'obj' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
      FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/*.ajs")
    end
  end
end
