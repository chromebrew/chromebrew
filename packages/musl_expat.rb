require 'package'

class Musl_expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.4.1-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/expat/expat/2.4.1/expat-2.4.1.tar.xz'
  source_sha256 'cf032d0dba9b928636548e32b327a2d66b1aab63c4f4a13dd132c2d1d2f2fb6a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1-1_armv7l/musl_expat-2.4.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1-1_armv7l/musl_expat-2.4.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1-1_i686/musl_expat-2.4.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_expat/2.4.1-1_x86_64/musl_expat-2.4.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0d3de6837cb658a742d53ed9c6df190708dd0a454802bc42e15d448a8e9fbe46',
     armv7l: '0d3de6837cb658a742d53ed9c6df190708dd0a454802bc42e15d448a8e9fbe46',
       i686: 'c549a1c5c37d959f9c29dd9018c0e7621e3cff64af77e46c0ab16a43f43ccd85',
     x86_64: 'dabf216e0c02afd4e7d98333c37de3f7aaba4fc0841d6079e6cb3be1db2811c3'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.patch
    system 'filefix'
  end

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --disable-shared \
        --enable-static \
        --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
