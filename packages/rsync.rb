require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://rsync.samba.org/ftp/rsync/src/rsync-3.3.0.tar.gz'
  source_sha256 '7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '9ec003fc1c46fcd0f1a47ae6f358fc3bf964c160736d81edc9deb0a6954129d3',
     armv7l: '9ec003fc1c46fcd0f1a47ae6f358fc3bf964c160736d81edc9deb0a6954129d3',
       i686: 'd6cdbe64eef2b542bdc49c7077b3370cb0d1823cc6c3477a5e4df347fc1b5592',
     x86_64: '9a63634c624037bfa5b294eb4dc36f817796ad201a947d86a7c52165e16e135d'
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
  no_zstd

  run_tests
end
