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
    aarch64: '7f5fe3311c73a4737cefdfe8553ee604c1e046376ca240711cc953186f35d590',
     armv7l: '7f5fe3311c73a4737cefdfe8553ee604c1e046376ca240711cc953186f35d590',
       i686: 'deb210dcd8e6db83798ff3e349669b726318ae4c99a8797b327e938c43e5e0c1',
     x86_64: 'fe4d81b538419c1e27d8600c3bd87c1a4011289fb7eddd58ad75a9e8b623decc'
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
