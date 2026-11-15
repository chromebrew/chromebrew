require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  @nss_ver = '3.119.1'
  @nspr_ver = '4.38.2'
  version "nss.#{@nss_ver}.nspr.#{@nspr_ver}"
  license 'MPL-2.0, GPL-2 or LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.mozilla.org/pub/security/nss/releases/NSS_#{@nss_ver.gsub('.', '_')}_RTM/src/nss-#{@nss_ver.gsub('.', '_')}-with-nspr-#{@nspr_ver}.tar.gz"
  source_sha256 '59bb55a59b02e4004fc26ad0aa1a13fe8d73c6c90c447dd2f2efb73fb81083ed'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3179545ce2c0369f8cc4f131301b017c5289d60c49ccb2729575400c0344b854',
     armv7l: '3179545ce2c0369f8cc4f131301b017c5289d60c49ccb2729575400c0344b854',
       i686: 'aef86f0ed5677ad9ed5f34553f2dfa4703ae1fa575e92942987144fe43197980',
     x86_64: '23498901e8df15c726328c8b0d89757737decca3afe89fb0943c3fc12c3cb208'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gyp_next' => :build
  depends_on 'sqlite' => :library
  depends_on 'zlib' => :executable

  def self.build
    @build64 = ARCH == 'x86_64' ? '1' : '0'
    @arch_cflags = ''
    @arch_ldflags = @arch_cflags

    Dir.chdir 'nss' do
      system "env opt_build=1 build_64=#{@build64} \
        NSS_ENABLE_WERROR=0 NS_USE_GCC=1 USEABSPATH=NO \
        NSS_GYP_PREFIX=#{CREW_PREFIX} CFLAGS='-pipe #{@arch_cflags}' \
        CXXFLAGS='-pipe #{@arch_cflags}' LDFLAGS='#{@arch_ldflags}' \
        ./build.sh -v --opt --gcc --gyp \
        --system-sqlite --disable-tests"
    end
    system "sed -i \
    -e 's,^libdir=.*,libdir=#{CREW_LIB_PREFIX},g' \
    -e 's,^prefix=.*,prefix=#{CREW_PREFIX},g' \
    -e 's,\${exec_prefix}/lib,\${exec_prefix}/#{ARCH_LIB},g' \
    dist/Release/lib/pkgconfig/nspr.pc"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/nss"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/nspr"
    FileUtils.rm Dir.glob('dist/Release/lib/*.so.TOC')
    FileUtils.mv 'dist/Release/lib', "dist/Release/#{ARCH_LIB}" unless ARCH_LIB == 'lib'
    FileUtils.cp_r Dir.glob('dist/Release/*'), CREW_DEST_PREFIX
    FileUtils.cp_r Dir.glob('dist/public/nss/*'), "#{CREW_DEST_PREFIX}/include/nss/"
    FileUtils.cp_r Dir.glob('dist/public/nspr/*'), "#{CREW_DEST_PREFIX}/include/nspr/"
    system "sed nss/pkg/pkg-config/nss.pc.in \
    -e 's,%libdir%,#{CREW_LIB_PREFIX},g' \
    -e 's,%prefix%,#{CREW_PREFIX},g' \
    -e 's,%exec_prefix%,#{CREW_PREFIX},g' \
    -e 's,%includedir%,#{CREW_PREFIX}/include/nss,g' \
    -e 's,%NSPR_VERSION%,#{@nspr_ver},g' \
    -e 's,%NSS_VERSION%,#{@nss_ver},g' | \
    install -Dm644 /dev/stdin #{CREW_DEST_LIB_PREFIX}/pkgconfig/nss.pc"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/pkgconfig/nss.pc",
                   "#{CREW_DEST_LIB_PREFIX}/pkgconfig/mozilla-nss.pc"
  end
end
