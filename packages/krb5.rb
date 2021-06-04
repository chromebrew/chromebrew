require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.19.1'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.1.tar.gz'
  source_sha256 'fa16f87eb7e3ec3586143c800d7eaff98b5e0dcdf0772af7d98612e49dbeb20b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1_armv7l/krb5-1.19.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1_armv7l/krb5-1.19.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1_i686/krb5-1.19.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1_x86_64/krb5-1.19.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ed77e5d8274ca8cd6acf53edca8d86479aaa67be18d69927424fa3b0572e970e',
     armv7l: 'ed77e5d8274ca8cd6acf53edca8d86479aaa67be18d69927424fa3b0572e970e',
       i686: 'ab646a5876870bbd762229dbad705f6826eaf34bd2f3838172916ffcc5067a3a',
     x86_64: 'dde095df31c2a2b8925d0d9323a9e447b07238cec09ae0e5a43191d0a7b2c94d'
  })

  depends_on 'ccache' => :build
  depends_on 'e2fsprogs'

  @k5libs = %w[libgssapi_krb5.a libgssrpc.a libk5crypto.a
               libkadm5clnt_mit.a libkadm5clnt.a libkadm5srv_mit.a libkadm5srv.a
               libkdb5.a libkrad.a libkrb5.a libkrb5support.a libverto.a]

  def self.build
    # First we build static libraries, then rebuild for shared libaries.
    Dir.chdir 'src' do
      # krb5 built with gcc10 or newer needs -fcommon
      # See https://github.com/ripple/rippled/pull/3813
      @cppflags = "#{CREW_COMMON_FLAGS} -I#{CREW_PREFIX}/include/et -fcommon"
      @path = "#{CREW_PREFIX}/bin:" + ENV['PATH']
      system "env CC='ccache gcc' #{CREW_ENV_OPTIONS} \
      CPPFLAGS='#{@cppflags}' \
      PATH=#{@path} \
      ./configure #{CREW_OPTIONS} \
      --localstatedir=#{CREW_PREFIX}/var/krb5kdc \
      --disable-shared \
      --enable-static \
      --with-system-et \
      --with-system-ss \
      --without-system-verto"
      system "env PATH=#{@path} \
      make -j#{CREW_NPROC}"
      # Set aside the static libraries.
      Dir.chdir 'lib' do
        @k5libs.each do |lib|
          FileUtils.cp lib, '../../' if File.exist?(lib)
        end
      end
      system 'make clean'
      system "env CC='ccache gcc' #{CREW_ENV_OPTIONS} \
      CPPFLAGS='#{@cppflags}' \
      PATH=#{@path} \
      ./configure #{CREW_OPTIONS} \
      --localstatedir=#{CREW_PREFIX}/var/krb5kdc \
      --enable-shared \
      --with-system-et \
      --with-system-ss \
      --without-system-verto"
      system "env PATH=#{@path} \
      make -j#{CREW_NPROC}"
    end
  end

  def self.install
    Dir.chdir 'src' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    # Now install the static libraries.
    @k5libs.each do |lib|
      FileUtils.cp lib, CREW_DEST_LIB_PREFIX if File.exist?(lib)
    end
  end
end
