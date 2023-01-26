require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.20.1'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.20/krb5-1.20.1.tar.gz'
  source_sha256 '704aed49b19eb5a7178b34b2873620ec299db08752d6a8574f95d41879ab8851'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1_armv7l/krb5-1.20.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1_armv7l/krb5-1.20.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1_i686/krb5-1.20.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1_x86_64/krb5-1.20.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9c02f47739672ffb168d41bc654e77ab6a3b07c3fbe7f4f32d2e4be279ee89ad',
     armv7l: '9c02f47739672ffb168d41bc654e77ab6a3b07c3fbe7f4f32d2e4be279ee89ad',
       i686: 'f41117ab29c09af9a50c2d064d6bbd0e7915c720e427869d714550b74c1ad0de',
     x86_64: '0dc50e8a13a6843f5ba79b62a3bcf303b6f9fbb3db9d241f65c5f07286dd1d50'
  })

  depends_on 'ccache' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  @k5libs = %w[libgssapi_krb5.a libgssrpc.a libk5crypto.a
               libkadm5clnt_mit.a libkadm5clnt.a libkadm5srv_mit.a libkadm5srv.a
               libkdb5.a libkrad.a libkrb5.a libkrb5support.a libverto.a]

  def self.build
    # First we build static libraries, then rebuild for shared libaries.
    Dir.chdir 'src' do
      # krb5 built with gcc10 or newer needs -fcommon
      # See https://github.com/ripple/rippled/pull/3813
      @cppflags = "#{CREW_COMMON_FLAGS} -I#{CREW_PREFIX}/include/et -fcommon"
      @path = "#{CREW_PREFIX}/bin:" + ENV.fetch('PATH', nil)
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
