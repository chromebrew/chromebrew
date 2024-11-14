ENV['CREW_DISABLE_ENV_OPTIONS'] = '1'
warn_level = $VERBOSE
$VERBOSE = nil
load "#{CREW_LIB_PATH}/lib/const.rb"
# Defines common musl build constants used in musl builds
MUSL_ARCH_SSP_CFLAGS = ''
MUSL_ARCH_C_FLAGS = ''
MUSL_ARCH_CXX_FLAGS = ''
case ARCH
when 'i686', 'x86_64'
  MUSL_ABI = ''
  MUSL_ARCH = ARCH
when 'aarch64', 'armv7l'
  MUSL_ABI = 'eabihf'
  MUSL_ARCH = 'armhf'
end

MUSL_CFLAGS = "-isysroot=#{CREW_MUSL_PREFIX} -B#{CREW_MUSL_PREFIX}/include -flto -pipe -O2 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{MUSL_ARCH_C_FLAGS} #{MUSL_ARCH_SSP_CFLAGS} -fcommon -fPIC -ffunction-sections -fdata-sections"
MUSL_CXXFLAGS = "-isysroot=#{CREW_MUSL_PREFIX} -B#{CREW_MUSL_PREFIX}/include -flto -pipe -O2 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{MUSL_ARCH_CXX_FLAGS} #{MUSL_ARCH_SSP_CFLAGS} -fcommon -fPIC -ffunction-sections -fdata-sections"
# Setting -static & -flto in CMAKE LDFLAGS breaks builds
MUSL_CMAKE_LDFLAGS = '-flto'
if @pkg.is_static?
  MUSL_LDFLAGS = "-L#{CREW_MUSL_PREFIX}/lib -Wl,-rpath=#{CREW_MUSL_PREFIX}/lib -Wl,--enable-new-dtags -Wl,--gc-sections -flto -isysroot=#{CREW_MUSL_PREFIX} -static --static"
  MUSL_PKG_CONFIG = 'pkg-config --static'
else
  MUSL_LDFLAGS = "-L#{CREW_MUSL_PREFIX}/lib -Wl,-rpath=#{CREW_MUSL_PREFIX}/lib -Wl,--enable-new-dtags -Wl,--dynamic-linker,#{CREW_MUSL_PREFIX}/lib/libc.so -Wl,--gc-sections -flto -isysroot=#{CREW_MUSL_PREFIX} "
  MUSL_PKG_CONFIG = 'pkg-config'
end
MUSL_ENV_OPTIONS = "PATH=#{CREW_MUSL_PREFIX}/bin:#{ENV.fetch('PATH', nil)} \
    CC='#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc' \
    CXX='#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-g++' \
    LD='#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-ld.gold -L#{CREW_MUSL_PREFIX}/lib' \
    AR=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-ar \
    LIBRARY_PATH=#{CREW_MUSL_PREFIX}/lib \
    MUSL_PKG_CONFIG='#{MUSL_PKG_CONFIG}' \
    PKG_CONFIG_LIBDIR=#{CREW_MUSL_PREFIX}/lib/pkgconfig \
    CFLAGS='#{MUSL_CFLAGS}' \
    CXXFLAGS='#{MUSL_CXXFLAGS}' \
    CPPFLAGS='-I#{CREW_MUSL_PREFIX}/include -fcommon -idirafter#{CREW_PREFIX}/include' \
    LDFLAGS='#{MUSL_LDFLAGS}'"
MUSL_CMAKE_OPTIONS = "PATH=#{CREW_MUSL_PREFIX}/bin:#{CREW_MUSL_PREFIX}/#{ARCH}-linux-musl#{MUSL_ABI}/bin:#{ENV.fetch('PATH', nil)} \
      CC='#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc' \
      CXX='#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-g++' \
      LD=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-ld.gold \
      AR=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-ar \
      MUSL_PKG_CONFIG='#{MUSL_PKG_CONFIG}' \
      PKG_CONFIG_LIBDIR=#{CREW_MUSL_PREFIX}/lib/pkgconfig \
      CFLAGS='#{MUSL_CFLAGS}' \
      CXXFLAGS='#{MUSL_CXXFLAGS}' \
      CPPFLAGS='-I#{CREW_MUSL_PREFIX}/include -fcommon -idirafter#{CREW_PREFIX}/include' \
      LDFLAGS='#{MUSL_CMAKE_LDFLAGS}' \
      cmake \
      -DCMAKE_INSTALL_PREFIX='#{CREW_MUSL_PREFIX}' \
      -DCMAKE_INSTALL_LIBDIR='#{CREW_MUSL_PREFIX}/lib' \
      -DCMAKE_LIBRARY_PATH='#{CREW_MUSL_PREFIX}/lib' \
      -DCMAKE_C_COMPILER=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc \
      -DCMAKE_CXX_COMPILER=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-g++ \
      -DCMAKE_INCLUDE_DIRECTORIES_BEFORE=ON \
      -DINCLUDE_DIRECTORIES=#{CREW_MUSL_PREFIX}/include \
      -DCMAKE_C_FLAGS='#{MUSL_CFLAGS}' \
      -DCMAKE_CXX_FLAGS='#{MUSL_CXXFLAGS}' \
      -DCMAKE_EXE_LINKER_FLAGS='#{MUSL_CMAKE_LDFLAGS}' \
      -DCMAKE_SHARED_LINKER_FLAGS='#{MUSL_CMAKE_LDFLAGS}' \
      -DCMAKE_STATIC_LINKER_FLAGS='#{MUSL_CMAKE_LDFLAGS}' \
      -DCMAKE_MODULE_LINKER_FLAGS='#{MUSL_CMAKE_LDFLAGS}' \
      -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE \
      -DCMAKE_BUILD_TYPE=Release"
MUSL_MESON_OPTIONS = <<~OPT.chomp
  -Dprefix=#{CREW_MUSL_PREFIX} \
  -Dlibdir=#{CREW_MUSL_PREFIX}/lib \
  -Dmandir=../man \
  -Dbuildtype=release \
  -Db_lto=true \
  -Dstrip=true \
  -Db_pie=true \
  -Dcpp_args='-O2' \
  -Dc_args='-O2'
OPT

$VERBOSE = warn_level

class Musl
  class << self
    def patchelf
      puts 'Running Musl.patchelf'.lightblue
      abort('No Patchelf found!').lightred unless File.exist?("#{CREW_PREFIX}/bin/patchelf")

      execfiles = `find . -executable -type f ! \\( -name \"*.a\" \\) -exec sh -c \"file -i \'{}\' | grep -q \'executable; charset=binary\'\" \\; -exec ls -1i {} \\; | sort -u -n -s -k1,1 | awk '{print $2}'`.chomp
      return if execfiles.to_s.empty?

      puts 'Running patchelf to patch binaries for musl paths'.lightblue
      execfiles.each_line(chomp: true) do |execfiletopatch|
        execfiletopatch = Dir.pwd + execfiletopatch.delete_prefix('.')
        system "patchelf --set-interpreter #{CREW_MUSL_PREFIX}/lib/libc.so #{execfiletopatch}"
        system "patchelf --set-rpath #{CREW_MUSL_PREFIX}/lib #{execfiletopatch}"
        neededlibs = `patchelf --print-needed #{execfiletopatch}`
        next if neededlibs.to_s.empty?

        neededlibs.each_line(chomp: true) do |neededlibspatch|
          next if neededlibspatch.include?("#{CREW_MUSL_PREFIX}/lib")

          neededlibspatchednamepath = "#{CREW_MUSL_PREFIX}/lib/" + File.basename(neededlibspatch)
          puts "patchelf --replace-needed #{neededlibspatch} #{neededlibspatchednamepath} #{execfiletopatch}"
          system "patchelf --replace-needed #{neededlibspatch} #{neededlibspatchednamepath} #{execfiletopatch}"
        end
      end
    end
  end
end
