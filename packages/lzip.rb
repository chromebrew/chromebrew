require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.22-2'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.22.tar.gz'
  source_sha256 'c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-2_armv7l/lzip-1.22-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-2_armv7l/lzip-1.22-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22_i686/lzip-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-2_x86_64/lzip-1.22-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c2845ab07bbaf3ece8c9fbe6ebc877b9ab2028d20f125d15dac95c6a805feab4',
     armv7l: 'c2845ab07bbaf3ece8c9fbe6ebc877b9ab2028d20f125d15dac95c6a805feab4',
       i686: 'c300c57d644cde5783a76dd125a2e4e80873a9c1f1f07dec84a594807423106a',
     x86_64: '03d91cc0ed167a0e1cc6a294123b138542ee6a4689461813cd21d058ff590487'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunwind' => :build if ARCH == 'i686'

  @abi = ''
  @arch_c_flags = ''
  @arch_cxx_flags = ''
  @libunwind = ''
  case ARCH
  when 'aarch64', 'armv7l'
    @abi = 'eabihf'
  when 'i686'
    @libunwind = '-lunwind'
  end

  @cflags = "-B#{CREW_PREFIX}/musl/include -pipe -O2 -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} -fcommon"
  @cxxflags = "-B#{CREW_PREFIX}/musl/include -pipe -O2 -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} -fcommon -static"
  @ldflags = "-L#{CREW_PREFIX}/musl/lib -static #{@libunwind}"
  @cmake_ldflags = ''

  @musldep_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
      LIBRARY_PATH='#{CREW_PREFIX}/musl/lib:$LIBRARY_PATH' \
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
    system 'make -j1'
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
