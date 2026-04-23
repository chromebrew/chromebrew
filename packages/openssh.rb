require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.3p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '908c3b1ae3e8d91caf33d570aa90d06004705ecd2120f43e26a88d3d66a5d462',
     armv7l: '908c3b1ae3e8d91caf33d570aa90d06004705ecd2120f43e26a88d3d66a5d462',
       i686: 'ebde2c74539a3a8e767f50ea83267cbbc4b2f28b657699846a4aafb01a5ac318',
     x86_64: '2e9ca10c0f21a2121b468a2205f57e33a4c77f426eb310d0433990c664b8311a'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libmd' => :executable
  depends_on 'libxcrypt' => :logical
  depends_on 'openssl' => :executable
  depends_on 'zlib' => :executable

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
