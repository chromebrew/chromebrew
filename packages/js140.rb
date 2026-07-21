require 'package'

class Js140 < Package
  description 'JavaScript interpreter and libraries - Version 140'
  homepage 'https://spidermonkey.dev/'
  version "140.13.0-#{CREW_ICU_VER}"
  license 'MPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{version.gsub("-#{CREW_ICU_VER}", '').split('-').first}esr/source/firefox-#{version.gsub("-#{CREW_ICU_VER}", '').split('-').first}esr.source.tar.xz"
  source_sha256 'f53b9dc6942abda1185aa7d79048f59fc075020da36b4dd6b31f668b88714d01'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd570a479dfd8ff36321b61082b7db4631818595e23b5cdd7a3d8209e70f96054',
     armv7l: 'd570a479dfd8ff36321b61082b7db4631818595e23b5cdd7a3d8209e70f96054',
     x86_64: 'b66b263c5de1d7515518e5734065290c52769032b1c9cf29150450acd3cf7b4c'
  })

  depends_on 'autoconf213' => :build
  depends_on 'cbindgen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' => :library
  depends_on 'libnotify' => :build
  depends_on 'llvm_dev' => :build # llvm-objdump is needed.
  depends_on 'ncurses' => :library
  depends_on 'nss' => :library
  depends_on 'py3_maturin' => :build
  depends_on 'py3_pre_commit' => :build
  depends_on 'py3_pycairo' => :build
  depends_on 'readline' => :library
  depends_on 'rust' => :build
  depends_on 'wget2' => :build
  depends_on 'zlib' => :library

  def self.patch
    patches = [
      ['https://gitlab.archlinux.org/archlinux/packaging/packages/js140/-/raw/main/0001-Bug-1973994-mozjs-140.pc-does-not-contain-DXP_UNIX-o.patch?ref_type=heads&inline=false', 'b5178a7b8a603b645cbae61467f3fa1fef6e9f34c90e4a22faf4ea2152a50fba'],
      ['https://gitlab.archlinux.org/archlinux/packaging/packages/js140/-/raw/main/0002-Bug-1969769-Change-uses-of-ast.Str-with-ast.Constant.patch?ref_type=heads&inline=false', '941db682a37888582eb1608b936d57c73d7ce4377f4831c73cabb56745734013'],
      ['https://gitlab.archlinux.org/archlinux/packaging/packages/js140/-/raw/main/0003-Bug-1983713-Use-non-deprecated-ast-value.-r-firefox-.patch?ref_type=heads&inline=false', 'a8ed1bf4a0e17118fe6e11b33840d9a2ab7023deb377c44d23a51f9daad06d1e'],
      ['https://gitlab.archlinux.org/archlinux/packaging/packages/js140/-/raw/main/0004-Bug-1983736-Patch-jsonschema-to-work-with-Python-3.1.patch?ref_type=heads&inline=false', '5173051257f4fd8ed7c0811f01126a6a0f17c9ab6e561b4e0a89cc67509ccdc5'],
      ['https://gitlab.archlinux.org/archlinux/packaging/packages/js140/-/raw/main/0005-Bug-1993797-Fix-AST-parsing-in-DecoratorVisitor-for-.patch?ref_type=heads&inline=false', 'ab43fa4fc086926e03bb0fcd2e7a0fac16a9f498461661951d043dc2ba41ca33']
    ]
    ConvenienceFunctions.patch(patches)
  end

  def self.build
    File.write '.mozconfig', <<~MOZCONFIG_EOF
      ac_add_options --disable-bootstrap
      ac_add_options --disable-debug
      ac_add_options --disable-debug-symbols
      ac_add_options --disable-jemalloc
      ac_add_options --disable-strip
      ac_add_options --enable-application=js
      ac_add_options --enable-hardening
      ac_add_options --enable-linker=#{CREW_LINKER}
      ac_add_options --enable-optimize
      ac_add_options --enable-readline
      ac_add_options --enable-release
      ac_add_options --enable-shared-js
      ac_add_options --enable-tests
      ac_add_options --libdir=#{CREW_LIB_PREFIX}
      ac_add_options --prefix=#{CREW_PREFIX}
      ac_add_options --with-intl-api
      ac_add_options --with-system-icu
      ac_add_options --with-system-nspr
      ac_add_options --with-system-zlib
      mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj
    MOZCONFIG_EOF
    FileUtils.mkdir_p 'obj'
    Dir.chdir 'obj' do
      # error: Cannot set `RUSTC_BOOTSTRAP=1` from build script of `packed_simd v0.3.4 (https://github.com/hsivonen/packed_simd?rev=0917fe780032a6bbb23d71be545f9c1834128d75#0917fe78)`.
      # note: Crates cannot set `RUSTC_BOOTSTRAP` themselves, as doing so would subvert the stability guarantees of Rust for your project.
      # help: If you're sure you want to do this in your project, set the environment variable `RUSTC_BOOTSTRAP=packed_simd` before running cargo instead.
      #
      # ENV['RUSTC_BOOTSTRAP'] = 'packed_simd,packed_simd_2,encoding_rs'
      system "CFLAGS='-fcf-protection=none' \
            CXXFLAGS='-fcf-protection=none' \
            CC=gcc \
            CXX=g++ \
            LD=#{CREW_LINKER} \
            RUSTUP_HOME='#{CREW_PREFIX}/share/rustup' \
            CARGO_HOME='#{CREW_PREFIX}/share/cargo' \
            LDFLAGS='-lreadline -ltinfo' \
            MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=pip \
            MOZ_BUILD_DATE=#{`date -u${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH} +%Y%m%d%H%M%S)`.chomp} \
            MOZ_NOSPAM=1 \
            MOZCONFIG=../.mozconfig \
            ../mach build"
    end
  end

  def self.install
    Dir.chdir 'obj' do
      system "DESTDIR=#{CREW_DEST_DIR} make install"
      FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/*.ajs")
    end
  end
end
