require 'package'

class Js102 < Package
  description 'Spidermonkey is a javaScript interpreter with libraries from Mozilla — Version 102'
  version '102.4.0'
  license 'MPL-2.0'
  compatibility 'all'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}esr/source/firefox-#{version}esr.source.tar.xz"
  source_sha256 'e79f0ddd4914dfbff61c5eea7ff28ad2dd12ecfbf3d63a41dab57d50171d904e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js102/102.4.0_armv7l/js102-102.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js102/102.4.0_armv7l/js102-102.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js102/102.4.0_i686/js102-102.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/js102/102.4.0_x86_64/js102-102.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cdebffea9ebee4e43ae1c1b3e69f8fa1f573fef22fb16a138da9ebb590c23f45',
     armv7l: 'cdebffea9ebee4e43ae1c1b3e69f8fa1f573fef22fb16a138da9ebb590c23f45',
       i686: 'c1b727f99b1fc175bda9e5e2f5059712f01e5b190d3528c838a3887861b38c58',
     x86_64: '3eab263b390fe708d484866d91faf01d389abf394f35f9e8b358fff2a334f478'
  })

  depends_on 'autoconf213' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libnotify' => :build
  depends_on 'llvm16_dev' => :build
  depends_on 'ncurses' # R
  depends_on 'nspr'
  depends_on 'nss' # R
  depends_on 'readline' # R
  depends_on 'rust' => :build
  depends_on 'zlibpkg' # R

  @rust_default_host = case ARCH
                       when 'aarch64', 'armv7l'
                         'armv7-unknown-linux-gnueabihf'
                       else
                         "#{ARCH}-unknown-linux-gnu"
                       end

  def self.patch
    # Python 3.10 fixes
    system 'sed -i s,collections.Sequence,collections.abc.Sequence,g python/mozbuild/mozbuild/util.py'
    system "sed -i 's/Iterable, OrderedDict/OrderedDict/' python/mozbuild/mozbuild/backend/configenvironment.py"
    system "sed -i '/from collections import OrderedDict/a from collections.abc import Iterable' python/mozbuild/mozbuild/backend/configenvironment.py"
    system "sed -i 's/collections import defaultdict, MutableSequence/collections import defaultdict/' testing/mozbase/manifestparser/manifestparser/filters.py"
    system "sed -i '/from collections import defaultdict/a from collections.abc import MutableSequence' testing/mozbase/manifestparser/manifestparser/filters.py"
    system "sed -i 's/collections import Iterable/collections.abc import Iterable/' python/mozbuild/mozbuild/makeutil.py"

    return unless ARCH == 'i686'

    # https://bugzilla.mozilla.org/show_bug.cgi?id=1729459#c25
    @math_x86_patch = <<~'PATCH_EOF'
      diff --git a/modules/fdlibm/src/math_private.h b/modules/fdlibm/src/math_private.h
      index 51d79f9c2ec59..fafd7d6fc1e0d 100644
      --- a/modules/fdlibm/src/math_private.h
      +++ b/modules/fdlibm/src/math_private.h
      @@ -30,7 +30,11 @@
        * Adapted from https://github.com/freebsd/freebsd-src/search?q=__double_t
        */

      +#if defined __FLT_EVAL_METHOD__ && (__FLT_EVAL_METHOD__ == 2)
      +typedef long double      __double_t;
      +#else
       typedef double      __double_t;
      +#endif
       typedef __double_t  double_t;

       /*
    PATCH_EOF
    File.write('math_x86.patch', @math_x86_patch)
    system 'patch -p 1 -i math_x86.patch'
  end

  def self.build
    @mozconfig = <<~MOZCONFIG_EOF
      ac_add_options --disable-debug
      ac_add_options --disable-debug-symbols
      ac_add_options --disable-jemalloc
      ac_add_options --disable-strip
      ac_add_options --enable-application=js
      ac_add_options --enable-hardening
      ac_add_options --enable-optimize
      ac_add_options --enable-readline
      ac_add_options --enable-release
      ac_add_options --enable-shared-js
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
            RUSTFLAGS='-Clto=thin' \
            RUSTUP_HOME='#{CREW_PREFIX}/share/rustup' \
            CARGO_HOME='#{CREW_PREFIX}/share/cargo' \
            LDFLAGS='-lreadline -ltinfo' \
            MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=system \
            MOZCONFIG=../.mozconfig \
            mold -run ../mach build"
    end
  end

  def self.install
    Dir.chdir 'obj' do
      system "DESTDIR=#{CREW_DEST_DIR} make install"
      FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/*.ajs")
    end
  end
end
