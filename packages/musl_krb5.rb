require 'package'

class Musl_krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.20-5c39'
  compatibility 'all'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  source_url 'https://github.com/krb5/krb5.git'
  git_hashtag '5c394dc54c9196c300bd99a66a3257692f520920'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.20-149d_armv7l/musl_krb5-1.20-149d-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.20-149d_armv7l/musl_krb5-1.20-149d-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.20-5c39_i686/musl_krb5-1.20-5c39-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.20-5c39_x86_64/musl_krb5-1.20-5c39-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ff862ef8c5c8711a2825f39a53b18ab39045424ed977f5a2ba6a431d3b706dd1',
     armv7l: 'ff862ef8c5c8711a2825f39a53b18ab39045424ed977f5a2ba6a431d3b706dd1',
       i686: '0e490d5c2ef27c23ddfc7f9247ad11d7d232f452c74ac45492a920d69e1640f1',
     x86_64: '16b09030992177017079d74ce3bbf60f553ba42a0ce107f7c8ec86ae6278034d'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    Dir.chdir 'src' do
      system 'autoreconf -fiv'
      system "#{MUSL_ENV_OPTIONS.gsub("LDFLAGS='",
                                      "LDFLAGS='-l:libncursesw.a -l:libtinfow.a ").prepend("LIBS='-l:libncursesw.a -l:libtinfow.a' ")} \
        ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --libdir=#{CREW_MUSL_PREFIX}/lib \
        --localstatedir=#{CREW_PREFIX}/var/krb5kdc \
        --disable-shared \
        --enable-static \
        --without-system-verto \
        --without-libedit \
        --disable-rpath \
        --without-keyutils"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'src' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
