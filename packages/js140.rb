# Adapted from Arch Linux js115 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/js115/-/blob/main/PKGBUILD?ref_type=heads

require 'package'

class Js140 < Package
  description 'JavaScript interpreter and libraries - Version 140'
  homepage 'https://spidermonkey.dev/'
  version '140.7.0'
  license 'MPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{version.split('-').first}esr/source/firefox-#{version.split('-').first}esr.source.tar.xz"
  source_sha256 '608a739071726f30236f7100ec5e30e1b8ec342d4e91e715948c287909cb1529'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20cc7045e2f2d41d8db93eaf8e7b78ce5ff77c51557e0a8e365bf4855751d4cd',
     armv7l: '20cc7045e2f2d41d8db93eaf8e7b78ce5ff77c51557e0a8e365bf4855751d4cd',
     x86_64: '733f2b3cf638515f8236465372e8d69585666dfbc46e48b4bc8a6d30072f92d4'
  })

  depends_on 'autoconf213' => :build
  depends_on 'cbindgen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libnotify' => :build
  depends_on 'llvm_dev' => :build # llvm-objdump is needed.
  depends_on 'ncurses' # R
  depends_on 'nss' # R
  depends_on 'py3_maturin' => :build
  depends_on 'py3_pre_commit' => :build
  depends_on 'py3_pycairo' => :build
  depends_on 'readline' # R
  depends_on 'rust' => :build
  depends_on 'wget2' => :build
  depends_on 'zlib' # R

  def self.patch
    # As per https://bugzilla.mozilla.org/show_bug.cgi?id=1973994
    system "sed -i '/* js_config_h */i #undef XP_UNIX' js/src/js-config.h.in"
    system "sed -i '/* js_config_h */i #undef XP_WIN' js/src/js-config.h.in"
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
      ENV['RUSTC_BOOTSTRAP'] = 'packed_simd,packed_simd_2,encoding_rs'
      system "CFLAGS='-fcf-protection=none' \
            CXXFLAGS='-fcf-protection=none' \
            CC=gcc \
            CXX=g++ \
            LD=#{CREW_LINKER} \
            RUSTUP_HOME='#{CREW_PREFIX}/share/rustup' \
            CARGO_HOME='#{CREW_PREFIX}/share/cargo' \
            LDFLAGS='-lreadline -ltinfo' \
            MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=pip \
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
