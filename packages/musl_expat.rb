require 'package'

class Musl_expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.4.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/expat/expat/2.4.1/expat-2.4.1.tar.xz'
  source_sha256 'cf032d0dba9b928636548e32b327a2d66b1aab63c4f4a13dd132c2d1d2f2fb6a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1_armv7l/musl_expat-2.4.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1_armv7l/musl_expat-2.4.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1_i686/musl_expat-2.4.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1_x86_64/musl_expat-2.4.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '312f91f73bb709176aac66f3484871c8dd2ab2eb8a8bdda863e3b7ad3a537bec',
     armv7l: '312f91f73bb709176aac66f3484871c8dd2ab2eb8a8bdda863e3b7ad3a537bec',
       i686: '4b58bd92dc6f4f945e4f6f0f9bcf85a0f4af877d7548c080f93ac6ef3e5d56c6',
     x86_64: 'f9c804469da09f0e846d902e3cdfcb4378e74797f036e0862071d02f41813ed9'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{@musldep_env_options} ./configure --prefix=#{CREW_PREFIX}/musl \
        --disable-shared \
        --enable-static \
        --with-pic"
    system 'make'
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
