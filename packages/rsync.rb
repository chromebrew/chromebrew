require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.5.0'
  license 'GPL-3'
  compatibility 'all'
  # source_url 'https://github.com/RsyncProject/rsync'
  # git_hashtag "v#{version}"
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 'c7ffd1ef653e99540f661e47cb00b7f9cad1ee6b972399b16f93d672656e0d33'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb57874b9d886d61aee990d7d37f41bce74d1995de50f4264245a0b03875a47c',
     armv7l: 'cb57874b9d886d61aee990d7d37f41bce74d1995de50f4264245a0b03875a47c',
       i686: '502eff03a119d362a052cf45613e7dc07c49cca48dd2071bfb641071da3f961c',
     x86_64: 'cbd8e845009b1cdf1c06286fe3eba4c604683348302034e1aed0af310b9e5847'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libiconv' => :executable
  depends_on 'lz4' => :executable
  depends_on 'openssl' => :executable
  depends_on 'popt' => :executable
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-openat2'
end
