require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.23.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf10a62ee4d52d2610a648b5c5103c6cc6f91360e7cb1c502eedb02e54e726c2',
     armv7l: 'cf10a62ee4d52d2610a648b5c5103c6cc6f91360e7cb1c502eedb02e54e726c2',
       i686: '872ee4e4e27ca94ada572f29c41281091f471ced27f24d0963c9086e9dd90d7c',
     x86_64: '2d1abb5f1896bffe19b985e8539dea193c9476ed3010db29f5d5c259d1ae23ba'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libidn2' => :library
  depends_on 'libunistring' => :library

  def self.patch
    # Update the PSL during build.
    downloader 'https://github.com/publicsuffix/list/raw/refs/heads/main/public_suffix_list.dat', 'SKIP', 'list/public_suffix_list.dat'
  end
end
