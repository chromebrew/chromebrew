require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.5.2'
  license 'GPL-3'
  compatibility 'all'
  # source_url 'https://github.com/RsyncProject/rsync'
  # git_hashtag "v#{version}"
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 'a10d591825251e070f74c98df3daad195def4ed81b4a2de16169026aea33f6c8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcad94e37477e1b60ff64bb5b9fac0cd1deb31cdd5a0ece1a1b571155e9db1de',
     armv7l: 'fcad94e37477e1b60ff64bb5b9fac0cd1deb31cdd5a0ece1a1b571155e9db1de',
       i686: 'd5ce3d778d476a0d0cba2723aa244482f2e3fafdfb8897f0f17ce9b3a8700a27',
     x86_64: '8560da2eac311e3aac26eb6a007ddb0a87c68f490b349c33baf80bfa56978a2b'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libiconv' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'lz4' => :executable
  depends_on 'openssl' => :executable
  depends_on 'popt' => :executable
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-openat2'
end
