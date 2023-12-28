require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.21.2'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.21/krb5-1.21.2.tar.gz'
  source_sha256 '9560941a9d843c0243a71b17a7ac6fe31c7cebb5bce3983db79e52ae7e850491'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.2_armv7l/krb5-1.21.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.2_armv7l/krb5-1.21.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.2_i686/krb5-1.21.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/krb5/1.21.2_x86_64/krb5-1.21.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3c9b9dd47e77adf9a413c6e5475017c0bb18b3498bd59985ce689c26c603098b',
     armv7l: '3c9b9dd47e77adf9a413c6e5475017c0bb18b3498bd59985ce689c26c603098b',
       i686: '6af0d60a68a5b63aaed64552e94e99cc9238ce4ebcf9e2bb25017c993b0e149d',
     x86_64: 'e73598b85c21ad90e56fe48b7af09f287c3a5962a2c7c57e35dd3090ebdccd20'
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
