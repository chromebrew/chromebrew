require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.4.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 '7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ec003fc1c46fcd0f1a47ae6f358fc3bf964c160736d81edc9deb0a6954129d3',
     armv7l: '9ec003fc1c46fcd0f1a47ae6f358fc3bf964c160736d81edc9deb0a6954129d3',
       i686: 'edbba6b8dd2ce07c6a413ab52b8e11adfd58fb6b3a18802cde43bd98bc12ead8',
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
