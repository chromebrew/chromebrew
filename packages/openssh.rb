require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.4p1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag "V_#{version.upcase.tr('.', '_').sub('P', '_P')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '756b6d69e3f0f1258bfc4ef6f0ff3d9dd391472092a08e45410656cf27e4d6dd',
     armv7l: '756b6d69e3f0f1258bfc4ef6f0ff3d9dd391472092a08e45410656cf27e4d6dd',
       i686: '3dd2ab43e116d0b8c7476fffc4ca4f7dea50c08bf0905b303edb56dfb2a0fa1a',
     x86_64: '6edb127094778e40f928f319a708713b80e10a0d255830a6df2ca2b61f592149'
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
