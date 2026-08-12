require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.5p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a49b789535c94fb16da76a328f95edda4b6b4fa4ab441a1f17004de94ad92ac',
     armv7l: '8a49b789535c94fb16da76a328f95edda4b6b4fa4ab441a1f17004de94ad92ac',
       i686: '4f87d5214448899bf86d8e07b0b4757a333432a4ecdc1f2660f61b824ceaca99',
     x86_64: '1dfd97196fa3036d6c7bbf91a1db376bceee10f3ba4d277ebac8e5a7395239bb'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'glibc_lib' => :library
  depends_on 'libmd' => :executable
  depends_on 'libmd' => :library
  depends_on 'libxcrypt' => :executable
  depends_on 'libxcrypt' => :library
  depends_on 'libxcrypt' => :logical
  depends_on 'openssl' => :executable
  depends_on 'openssl' => :library
  depends_on 'zlib' => :executable
  depends_on 'zlib' => :library

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
