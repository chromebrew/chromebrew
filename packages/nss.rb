require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  @nss_ver = '3.69.1'
  @nspr_ver = '4.32'
  version "nss.#{@nss_ver}.nspr.#{@nss_ver}"
  license 'MPL-2.0, GPL-2 or LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_69_1_RTM/src/nss-3.69.1-with-nspr-4.32.tar.gz'
  source_sha256 '976dd57391aa269aa2961ac7ae002dc49935f855263df58b59b1dd4836d47cb7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nss/nss.3.69.1.nspr.4.32_armv7l/nss-nss.3.69.1.nspr.4.32-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nss/nss.3.69.1.nspr.4.32_armv7l/nss-nss.3.69.1.nspr.4.32-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nss/nss.3.69.1.nspr.4.32_i686/nss-nss.3.69.1.nspr.4.32-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nss/nss.3.69.1.nspr.4.32_x86_64/nss-nss.3.69.1.nspr.4.32-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e68a620a7b7f35289f401561e3c86ff1fceb38d0b0652da7e6c531addc020a14',
     armv7l: 'e68a620a7b7f35289f401561e3c86ff1fceb38d0b0652da7e6c531addc020a14',
       i686: '2b16871a705710c6f772c255b68572013e765658cb5f791b9fdaf697c1bf36ed',
     x86_64: '89f80e57d77168fe58e28f60e245a18256dd3b1c68640a1430fc512f93e01b01'
  })

  depends_on 'gyp_next' => :build

  def self.build
    @build_64 = ARCH == 'x86_64' ? '1' : '0'
    @arch_cflags = ''
    @arch_ldflags = @arch_cflags

    Dir.chdir 'nss' do
      system "env opt_build=1 build_64=#{@build_64} \
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
    FileUtils.rm 'dist/Release/lib/*.so.TOC'
    FileUtils.mv 'dist/Release/lib', "dist/Release/#{ARCH_LIB}" unless ARCH_LIB == 'lib'
    FileUtils.cp_r 'dist/Release/*', CREW_DEST_PREFIX
    FileUtils.cp_r 'dist/public/nss/*', "#{CREW_DEST_PREFIX}/include/nss/"
    FileUtils.cp_r 'dist/public/nspr/*', "#{CREW_DEST_PREFIX}/include/nspr/"
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
