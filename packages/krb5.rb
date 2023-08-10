require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.21.1'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.21/krb5-1.21.1.tar.gz'
  source_sha256 '7881c3aaaa1b329bd27dbc6bf2bf1c85c5d0b6c7358aff2b35d513ec2d50fa1f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.1_armv7l/krb5-1.21.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.1_armv7l/krb5-1.21.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.1_i686/krb5-1.21.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.1_x86_64/krb5-1.21.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '78b5a484074f739462c78a9409fcde96eb76c004bd7a58500653b56995793c16',
     armv7l: '78b5a484074f739462c78a9409fcde96eb76c004bd7a58500653b56995793c16',
       i686: '85ba1f202022f6976e432d4fa36ab6ca814085df7680bef413ce58cd7081aa0a',
     x86_64: '00397b5f6b16de46624146d8ddae4a81108984d6ffd38fc86af53b397f2cb5ab'
  })

  depends_on 'ccache' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
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
