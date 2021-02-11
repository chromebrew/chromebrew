require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  @_ver = '3.61'
  version @_ver
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_61_RTM/src/nss-3.61-with-nspr-4.29.tar.gz'
  source_sha256 '812468f3cf22917f9647fec7997f4ab27ae4167811d9cbdc831f41f5ed281c5d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.61-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.61-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.61-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.61-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '812f36d5c1875cf8803097265483b8a558194c6f0778977d55637407682ba51c',
     armv7l: '812f36d5c1875cf8803097265483b8a558194c6f0778977d55637407682ba51c',
       i686: 'e724b986a9a2edce790a8bef0b89d096ff46cb93815fc2d7bf8beb950af851f5',
     x86_64: 'ba50721b2e968c49fbd5d4a90112ff27374903d33dbcfc3f1877b2c7074adbcd'
  })

  depends_on 'gyp_next' => :build
  depends_on 'nspr'

  def self.build
    ENV['opt_build'] = '1'
    ENV['build_64'] = if ARCH == 'x86_64'
                        '1'
                      else
                        '0'
                      end
    @ARCH_CFLAGS = if ARCH == 'armv7l'
                     ''
                   else
                     '-flto=auto'
                   end
    @ARCH_LDFLAGS = if ARCH == 'armv7l'
                      ''
                    else
                      '-flto=auto'
                    end

    ENV['NS_USE_GCC'] = '1'
    ENV['CPPFLAGS'] = "-I#{CREW_PREFIX}/include/nspr"
    ENV['USEABSPATH'] = 'NO'
    ENV['NSS_GYP_PREFIX'] = CREW_PREFIX
    Dir.chdir 'nss' do
      system "env CFLAGS='-pipe #{@ARCH_CFLAGS}' CXXFLAGS='-pipe #{@ARCH_CFLAGS}' LDFLAGS='#{@ARCH_LDFLAGS}' \
        ./build.sh -v --opt --gcc --gyp --with-nspr=#{CREW_PREFIX}/include/nspr --system-nspr --system-sqlite --disable-tests"
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/nss"
    FileUtils.rm Dir.glob('dist/Release/lib/*.so.TOC')
    FileUtils.mv 'dist/Release/lib', "dist/Release/#{ARCH_LIB}" unless ARCH_LIB.to_s == 'lib'
    FileUtils.cp_r Dir.glob('dist/Release/*'), CREW_DEST_PREFIX.to_s
    FileUtils.cp_r Dir.glob('dist/public/nss/*'), "#{CREW_DEST_PREFIX}/include/nss/"

    system "sed nss/pkg/pkg-config/nss.pc.in \
    -e \"s,%libdir%,#{CREW_LIB_PREFIX},g\" \
    -e \"s,%prefix%,#{CREW_PREFIX},g\" \
    -e \"s,%exec_prefix%,#{CREW_PREFIX}/bin,g\" \
    -e \"s,%includedir%,#{CREW_PREFIX}/include/nss,g\" \
    -e \"s,%NSPR_VERSION%,$(pkg-config --modversion nspr),g\" \
    -e \"s,%NSS_VERSION%,#{@_ver},g\" | \
    install -Dm644 /dev/stdin #{CREW_DEST_LIB_PREFIX}/pkgconfig/nss.pc"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/pkgconfig/nss.pc",
                   "#{CREW_DEST_LIB_PREFIX}/pkgconfig/mozilla-nss.pc"
  end
end
