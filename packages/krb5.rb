require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.20.1-1'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.20/krb5-1.20.1.tar.gz'
  source_sha256 '704aed49b19eb5a7178b34b2873620ec299db08752d6a8574f95d41879ab8851'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1-1_armv7l/krb5-1.20.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1-1_armv7l/krb5-1.20.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1-1_i686/krb5-1.20.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.20.1-1_x86_64/krb5-1.20.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80b1c0a265ce4a1ad7838189c010513aae8dd8b10578d98a8d7e56df66fc70ce',
     armv7l: '80b1c0a265ce4a1ad7838189c010513aae8dd8b10578d98a8d7e56df66fc70ce',
       i686: 'ed85e0ab5d700e98aa67e616b23c13734234255332cb6b51e6872238f3c2998e',
     x86_64: 'e31008fe76d9db3740c6c874bb501cf5d716c7ceb5fe61e8f43a25b653042e8b'
  })

  depends_on 'ccache' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  def self.build
    Dir.chdir 'src' do
      # krb5 built with gcc10 or newer needs -fcommon
      # See https://github.com/ripple/rippled/pull/3813
      @cppflags = "#{CREW_COMMON_FLAGS} -I#{CREW_PREFIX}/include/et -fcommon"
      @path = "#{CREW_PREFIX}/bin:" + ENV.fetch('PATH', nil)
      system "CPPFLAGS='#{@cppflags}' \
      PATH=#{@path} \
      mold -run ./configure #{CREW_OPTIONS} \
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
  end
end
