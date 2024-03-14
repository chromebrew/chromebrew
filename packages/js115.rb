# Adapted from Arch Linux js115 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/js115/-/blob/main/PKGBUILD?ref_type=heads

require 'package'

class Js115 < Package
  description 'JavaScript interpreter and libraries - Version 115'
  homepage 'https://spidermonkey.dev/'
  version '115.8.0'
  license 'MPL-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}esr/source/firefox-#{version}esr.source.tar.xz"
  source_sha256 'af8086f23efc8492d286671f6035b1a915de6f4ed5c7897e40be0e1cb6b895ea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a45ee8e0d9e22bc758ba6743649b392a4b16445c60d01576f5f1d7e12f64ce3d',
     armv7l: 'a45ee8e0d9e22bc758ba6743649b392a4b16445c60d01576f5f1d7e12f64ce3d',
     x86_64: '818511592eb8bcb646b905dd7fdfcfe1a5f3530f0c9f7ec9ae5693af82085a84'
  })

  depends_on 'autoconf213' => :build
  depends_on 'ccache' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libnotify' => :build
  depends_on 'llvm18_dev' => :build
  depends_on 'ncurses' # R
  depends_on 'nspr'
  depends_on 'nss' # R
  depends_on 'py3_pycairo' => :build
  depends_on 'readline' # R
  depends_on 'rust' => :build
  depends_on 'zlibpkg' # R

  @rust_default_host = case ARCH
                       when 'aarch64', 'armv7l'
                         'armv7-unknown-linux-gnueabihf'
                       else
                         "#{ARCH}-unknown-linux-gnu"
                       end

  def self.build
    @mozconfig = <<~MOZCONFIG_EOF
      ac_add_options --disable-bootstrap
      ac_add_options --disable-debug
      ac_add_options --disable-debug-symbols
      ac_add_options --disable-jemalloc
      ac_add_options --disable-strip
      ac_add_options --enable-application=js
      ac_add_options --enable-hardening
      ac_add_options --enable-linker=lld
      ac_add_options --enable-optimize
      ac_add_options --enable-readline
      ac_add_options --enable-release
      ac_add_options --enable-shared-js
      ac_add_options --enable-tests
      ac_add_options --libdir=#{CREW_LIB_PREFIX}
      ac_add_options --prefix=#{CREW_PREFIX}
      ac_add_options --with-intl-api
      ac_add_options --with-system-nspr
      ac_add_options --with-system-zlib
      mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj
    MOZCONFIG_EOF
    File.write('.mozconfig', @mozconfig)
    if %w[armv7l aarch64].include?(ARCH)
      # see https://bugzilla.mozilla.org/show_bug.cgi?id=1786621
      open('.mozconfig', 'a') do |f|
        f.puts 'ac_add_options --with-system-icu'
      end
    else
      open('.mozconfig', 'a') do |f|
        f.puts 'ac_add_options --enable-rust-simd'
        f.puts 'ac_add_options --without-system-icu'
      end
    end
    FileUtils.mkdir_p 'obj'
    Dir.chdir 'obj' do
      # error: Cannot set `RUSTC_BOOTSTRAP=1` from build script of `packed_simd v0.3.4 (https://github.com/hsivonen/packed_simd?rev=0917fe780032a6bbb23d71be545f9c1834128d75#0917fe78)`.
      # note: Crates cannot set `RUSTC_BOOTSTRAP` themselves, as doing so would subvert the stability guarantees of Rust for your project.
      # help: If you're sure you want to do this in your project, set the environment variable `RUSTC_BOOTSTRAP=packed_simd` before running cargo instead.
      ENV['RUSTC_BOOTSTRAP'] = 'packed_simd,packed_simd_2,encoding_rs'
      system "CFLAGS='-fcf-protection=none' \
            CXXFLAGS='-fcf-protection=none' \
            CC=gcc CXX=g++ \
            LD=mold \
            RUSTFLAGS='-Clto=thin' \
            RUSTUP_HOME='#{CREW_PREFIX}/share/rustup' \
            CARGO_HOME='#{CREW_PREFIX}/share/cargo' \
            LDFLAGS='-lreadline -ltinfo' \
            MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=system \
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
