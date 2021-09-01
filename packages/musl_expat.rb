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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1_x86_64/musl_expat-2.4.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a1c4fae29ea46a373df90988347378bf9c726198d514b86b6cce290cbfe3d6fb',
     armv7l: 'a1c4fae29ea46a373df90988347378bf9c726198d514b86b6cce290cbfe3d6fb',
     x86_64: 'ead1902f0c4b2ac25e0d802f8c51612c466be6581852462cab3ec01ab12d6d19'
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
