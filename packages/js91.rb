require 'package'

class Js91 < Package
  description 'Spidermonkey is a javaScript interpreter with libraries from Mozilla — Version 91'
  homepage 'https://spidermonkey.dev/'
  version '91.4.1'
  license 'MPL-2.0'
  compatibility 'all'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}esr/source/firefox-#{version}esr.source.tar.xz"
  source_sha256 '75e98daf53c5aea19d711a625d5d5e6dfdc8335965d3a19567c62f9d2961fc75'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '4b30eda6f946fc551ecd53012c149e7954b43eadf14004fb544c47e27200a1e5',
     armv7l: '4b30eda6f946fc551ecd53012c149e7954b43eadf14004fb544c47e27200a1e5',
       i686: '8ce4a0556e26954dc4efa14aa58ab25b4e320c1ac1c5abd9f1c307326ceb0341',
     x86_64: '9c0409340ef5882409697eb0fa452fd6267cdc93f535d27dfeb2b8fac43a1b15'
  })

  depends_on 'autoconf213' => :build
  depends_on 'rust' => :build
  depends_on 'llvm16_dev' => :build
  depends_on 'nspr'

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

    # Fixes https://bugs.gentoo.org/816975
    system "curl -Lf 'https://816975.bugs.gentoo.org/attachment.cgi?id=745218&action=diff&format=raw&headers=1' -o i686_math.patch"
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest(File.read('i686_math.patch')) == 'fcba8ce061545e893d9eebd3057cee150362fa23d7f3de4b249ec595789a0688'
    system('patch -Np1 -i i686_math.patch')
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
      ac_add_options --without-system-icu
      ac_add_options --with-system-nspr
      ac_add_options --with-system-zlib
      mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj
    MOZCONFIG_EOF
    File.write('.mozconfig', @mozconfig)
    unless %w[armv7l aarch64].include?(ARCH)
      open('.mozconfig', 'a') do |f|
        f.puts 'ac_add_options --enable-rust-simd'
      end
    end
    FileUtils.mkdir_p 'obj'
    Dir.chdir 'obj' do
      # error: Cannot set `RUSTC_BOOTSTRAP=1` from build script of `packed_simd v0.3.4 (https://github.com/hsivonen/packed_simd?rev=0917fe780032a6bbb23d71be545f9c1834128d75#0917fe78)`.
      # note: Crates cannot set `RUSTC_BOOTSTRAP` themselves, as doing so would subvert the stability guarantees of Rust for your project.
      # help: If you're sure you want to do this in your project, set the environment variable `RUSTC_BOOTSTRAP=packed_simd` before running cargo instead.
      ENV['RUSTC_BOOTSTRAP'] = 'packed_simd,encoding_rs'
      system "CFLAGS='-fcf-protection=none' \
            CXXFLAGS='-fcf-protection=none' \
            CC=gcc CXX=g++ \
            RUSTFLAGS='-Clto=thin' \
            RUSTUP_HOME='#{CREW_PREFIX}/share/rustup' \
            CARGO_HOME='#{CREW_PREFIX}/share/cargo' \
            LDFLAGS='-lreadline -ltinfo' \
            MACH_USE_SYSTEM_PYTHON=1 \
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
