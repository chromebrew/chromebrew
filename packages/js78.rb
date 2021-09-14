require 'package'

class Js78 < Package
  description 'Spidermonkey is a javaScript interpreter with libraries from Mozilla — Version 78'
  @_ver = '78.13.0'
  version @_ver
  license 'MPL-2.0'
  compatibility 'all'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{@_ver}esr/source/firefox-#{@_ver}esr.source.tar.xz"
  source_sha256 '19f9a9e2c2473cb37d57a49a1b2661a8236c4930df9b251d5e9ae274292b4f6c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js78/78.13.0_armv7l/js78-78.13.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js78/78.13.0_armv7l/js78-78.13.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js78/78.13.0_x86_64/js78-78.13.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c411fce679ebaf36c0f5eb24232499da3902b34561a62555cdb38a0832ca8647',
     armv7l: 'c411fce679ebaf36c0f5eb24232499da3902b34561a62555cdb38a0832ca8647',
     x86_64: '1f95140b994a39b9a2d71f08099e3d4c0f34f5487e2ee24b54e991026c31bc20'
  })

  depends_on 'autoconf213' => :build
  depends_on 'rust' => :build
  depends_on 'llvm' => :build
  depends_on 'nspr'

  @rust_default_host = case ARCH
                       when 'aarch64', 'armv7l'
                         'armv7-unknown-linux-gnueabihf'
                       else
                         "#{ARCH}-unknown-linux-gnu"
                       end

  def self.patch
    # Ubuntu patches
    # http://changelogs.ubuntu.com/changelogs/pool/main/m/mozjs78/mozjs78_78.13.0-1/changelog
    patch_url = 'http://archive.ubuntu.com/ubuntu/pool/main/m/mozjs78/mozjs78_78.13.0-1.debian.tar.xz'
    patch_sha256 = 'e62ecffa465bf6652f57502e1a088902f2b57d0391a81f87eb98930cb6a0e3dc'

    system "curl -Ls #{patch_url} -o unzippatches.tar.xz"
    unless Digest::SHA256.hexdigest(File.read('./unzippatches.tar.xz')) == patch_sha256
      abort 'Checksum mismatch :/ try again'
    end
    system('tar', '-xf', 'unzippatches.tar.xz')

    system('for i in `cat debian/patches/series`; do  patch -p 1 < debian/patches/$i; done')

    # Arch Patches
    # patch2_url = 'https://github.com/archlinux/svntogit-packages/raw/packages/js78/trunk/0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch'
    # patch2_sha256 = 'ad3dd149651d76c1c3de2dc71d3fb3361181a1add75ff095df7bfba88a4e4ad6'
    # system('curl', '-Lf', patch2_url, '-o', '0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch')
    # unless Digest::SHA256.hexdigest(File.read('./0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch')) == patch2_sha256
    #  abort 'Checksum mismatch :/ try again'
    # end
    # system('patch -p 1 < ./0002-Bug-1667736-Update-packed_simd-to-compile-on-Rust-1..patch')
  end

  def self.build
    FileUtils.mkdir_p 'obj'
    Dir.chdir 'obj' do
      system '../js/src/configure --help'
      system "env CFLAGS='-stdlib=libc++ -flto=thin' \
            RUSTFLAGS='-Clinker-plugin-lto' \
            RUSTUP_HOME='#{CREW_PREFIX}/share/rustup' \
            CARGO_HOME='#{CREW_PREFIX}/share/cargo' \
            AUTOCONF=#{CREW_PREFIX}/bin/autoconf-2.13 \
            CXXFLAGS='-I#{CREW_PREFIX}/include/c++/v1/ -flto=thin'
            CC=clang \
            CXX='clang++ -stdlib=libc++ -I#{CREW_PREFIX}/include/c++/v1/ -flto=thin' \
            AR=llvm-ar NM=llvm-nm RANLIB=llvm-ranlib \
            LDFLAGS='-lreadline -ltinfo -flto=thin' \
            ../js/src/configure --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-debug \
            --disable-debug-symbols \
            --disable-jemalloc \
            --disable-strip \
            --enable-readline \
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
