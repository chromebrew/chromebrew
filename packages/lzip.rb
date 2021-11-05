require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.22-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.22.tar.gz'
  source_sha256 'c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_armv7l/lzip-1.22-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_armv7l/lzip-1.22-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_i686/lzip-1.22-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_x86_64/lzip-1.22-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1af4e5160612003a2dcf992da1e250f69e94e0541afbc362ef08c64f03fd804b',
     armv7l: '1af4e5160612003a2dcf992da1e250f69e94e0541afbc362ef08c64f03fd804b',
       i686: 'cf44af1ba5957bf2a5f811f10d1dd861cf03045d4ced66bd36b531c64b2116f2',
     x86_64: '2238d47dee1af70ab2f3cce80208c73e0f8f1dec325d48ae92d80641ac09cd12'
  })

  depends_on 'musl_native_toolchain' => :build

  @abi = ''
  @arch_c_flags = ''
  @arch_cxx_flags = ''
  case ARCH
  when 'aarch64', 'armv7l'
    @abi = 'eabihf'
  end

  @cflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} -fcommon"
  @cxxflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} -fcommon -static"
  @ldflags = "-L#{CREW_PREFIX}/musl/lib -flto -static"
  @cmake_ldflags = '-flto'

  @musldep_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
      CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
      CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
      LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
      PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      CFLAGS='#{@cflags}' \
      CXXFLAGS='#{@cxxflags}' \
      CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
      LDFLAGS='#{@ldflags}'"

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}/musl \
      --datarootdir=#{CREW_PREFIX}/share \
      #{@musldep_env_options}"
    system 'make'
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../musl/bin/lzip', 'lzip'
    end
  end

  def self.check
    system 'make', 'check'
  end
end
