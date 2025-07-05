require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.21.5-2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56fd7e35ce2706b2b4cf60a74b106ea0b923d14db34ad24e478f72bc070e9160',
     armv7l: '56fd7e35ce2706b2b4cf60a74b106ea0b923d14db34ad24e478f72bc070e9160',
       i686: '8caf19357b4bb6303be7fe58cb42397978ef8179644efab1e33972c3c788c501',
     x86_64: '56c4274e773e48dccb6c6a0fa5f81f35b90794c63b121b252547daa1c473c797'
  })

  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R

  def self.patch
    # Update the PSL during build.
    downloader 'https://github.com/publicsuffix/list/raw/refs/heads/main/public_suffix_list.dat', 'SKIP', 'list/public_suffix_list.dat'
  end
end
