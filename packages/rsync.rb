require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.4.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 '7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c54301a434d5d6dd2ae9fa9fc70d17b7fdf7b4230160bdecad5f3e62d4ffb9e',
     armv7l: '8c54301a434d5d6dd2ae9fa9fc70d17b7fdf7b4230160bdecad5f3e62d4ffb9e',
       i686: 'a9cf7e10199a2ef329b39d5b15118e0cda2a27876bd31f2438010335116b3bfe',
     x86_64: '469183611bff51c3a412f68d6a58c498947ac58444cc9d4178a52332f178f5b6'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' # R
  depends_on 'zstd' # R

  no_patchelf

  run_tests
end
