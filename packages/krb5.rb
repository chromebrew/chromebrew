require 'buildsystems/autotools'

class Krb5 < Autotools
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos/'
  version '1.22.2'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url "https://web.mit.edu/kerberos/dist/krb5/#{version.sub(/\.\d+$/, '')}/krb5-#{version}.tar.gz"
  source_sha256 '074de0ecf72199f091c88812d46090c27724fd36a1284b5f44bc35b8dd31a59e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd07b691662223916e3c030af5db17e7931e15a06ed5c6275bf0ccfafb9865261',
     armv7l: 'd07b691662223916e3c030af5db17e7931e15a06ed5c6275bf0ccfafb9865261',
       i686: '9ebda0a19b9270d9faedea58287c69c83e720b1ab28f25659259bf12cdf9c770',
     x86_64: '2e15c20afb9dbe75a27ac94a4c8a3b01ec093ae22145a8a5b9604e535b4737be'
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
