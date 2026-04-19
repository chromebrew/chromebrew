require 'buildsystems/autotools'

class Tcpflow < Autotools
  description 'TCP/IP packet demultiplexer'
  homepage 'https://github.com/simsong/tcpflow'
  version '1.6.1-8d47b53'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/simsong/tcpflow.git'
  git_hashtag '8d47b53a54da58e9c9b78efed8b379d98c6113e4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaae1be015e7acf78b6c4e94f66d1ddb89ef638ea3037ec9d15c001a66bf51a9',
     armv7l: 'aaae1be015e7acf78b6c4e94f66d1ddb89ef638ea3037ec9d15c001a66bf51a9',
     x86_64: 'e7599e3d79fa5dd2592316919d088eaa36c19ed43c075a952781f4e9a9b8441b'
  })

  depends_on 'boost' => :build
  depends_on 'bzip2' => :executable
  depends_on 'cairo' => :executable
  depends_on 'expat' => :executable
  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'harfbuzz' # R
  depends_on 'libcap_ng' => :executable
  depends_on 'libmd' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pixman' => :executable
  depends_on 'sqlite' => :executable
  depends_on 'zlib' => :executable
end
