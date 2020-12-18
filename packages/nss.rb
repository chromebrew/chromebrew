require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  version '3.59'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_59_RTM/src/nss-3.59-with-nspr-4.29.tar.gz'
  source_sha256 '2e2c09c17b1c9f43a2f0a5d83a30a712bff3016d2b7cf5a3dd904847292607ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.59-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.59-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.59-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.59-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f1ab2d6fbaa5d94e51fa485c9325ae7ddd4d8df13ddfd87cb51aa89133c5feb',
     armv7l: '9f1ab2d6fbaa5d94e51fa485c9325ae7ddd4d8df13ddfd87cb51aa89133c5feb',
       i686: 'c54d6fbf8d44db101797e5d5b610baef75de5c92a37dec48cc6cb810e1d14f1c',
     x86_64: '41ff455950be5e96a72c494c4a1993f5efbbe9d8a1c747682bc279fd7bd156eb',
  })

  depends_on 'gyp' => :build
  depends_on 'nspr'
  depends_on 'sqlite'

  def self.build
    ENV['BUILD_OPT'] = '1'
    if ARCH == 'x86_64'
      ENV['USE_64'] = '1'
    else
      ENV['USE_X32'] = '1'
    end
    ENV['NS_USE_GCC'] = '1'
    ENV['CPPFLAGS'] = "-I#{CREW_PREFIX}/include/nspr"
    ENV['USEABSPATH'] = 'NO'
    ENV['NSS_GYP_PREFIX'] = CREW_PREFIX
    Dir.chdir 'nss' do
      system "./build.sh -v --opt --gcc --gyp --with-nspr=#{CREW_PREFIX}/include/nspr --system-nspr --system-sqlite --disable-tests"
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/nss"
    FileUtils.rm Dir.glob('dist/Release/lib/*.so.TOC')
    FileUtils.mv "dist/Release/lib","dist/Release/#{ARCH_LIB}" unless "#{ARCH_LIB}" == "lib"
    FileUtils.cp_r Dir.glob('dist/Release/*'), "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r Dir.glob('dist/public/nss/*'), "#{CREW_DEST_PREFIX}/include/nss/"
  end
end
