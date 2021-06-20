require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  @_ver = '1.19.1'
  version @_ver + '-1'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.1.tar.gz'
  source_sha256 'fa16f87eb7e3ec3586143c800d7eaff98b5e0dcdf0772af7d98612e49dbeb20b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1-1_armv7l/krb5-1.19.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1-1_armv7l/krb5-1.19.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1-1_i686/krb5-1.19.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.19.1-1_x86_64/krb5-1.19.1-1-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: '3580a0f77f18a4c76b1218596ff8b774d325036fe7c5c9c54c898665300f123e',
     armv7l: '3580a0f77f18a4c76b1218596ff8b774d325036fe7c5c9c54c898665300f123e',
       i686: '212f2bea3b6ec825b609703e0385e2a80de7c56b6c1cca4e6680a60dc8808fb9',
     x86_64: '2801e5e94ff094d3bfa86992042c57ee6bc15c13ce4d63b08c4b93c264114a25',
  })

  depends_on 'ccache' => :build

  @k5libs = %w[libgssapi_krb5.a libgssrpc.a libk5crypto.a libcom_err.a
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
      --without-system-et \
      --without-system-ss \
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
      --without-system-et \
      --without-system-ss \
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
