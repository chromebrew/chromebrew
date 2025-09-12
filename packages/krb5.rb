require 'buildsystems/autotools'

class Krb5 < Autotools
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos/'
  version '1.22.1'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url "https://web.mit.edu/kerberos/dist/krb5/#{version.split('.')[0..1].join('.')}/krb5-#{version}.tar.gz"
  source_sha256 '9560941a9d843c0243a71b17a7ac6fe31c7cebb5bce3983db79e52ae7e850491'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62318d53977497f7bf6c6038f5d17603685af369b8ba35ae1fa705e9f084bc59',
     armv7l: '62318d53977497f7bf6c6038f5d17603685af369b8ba35ae1fa705e9f084bc59',
       i686: 'd08304b052307c1ad9d484f405ab7452e8bf9250fd9a62473e6e4fec1fe4db05',
     x86_64: '6f0019b8f7c1d58dcdd4ddaf6dc74f3d59c52f43fa7ffabe0da05dccfdb36afd'
  })

  depends_on 'ccache' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  autotools_build_relative_dir 'src'

  autotools_configure_options "--localstatedir=#{CREW_PREFIX}/var/krb5kdc \
      --enable-shared \
      --with-system-et \
      --with-system-ss \
      --without-system-verto"
end
