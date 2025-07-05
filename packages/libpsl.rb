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
    aarch64: '15c6b9fa6bca331c7ed30dfb0572f59450367caf21b04eb6265e06d46f912002',
     armv7l: '15c6b9fa6bca331c7ed30dfb0572f59450367caf21b04eb6265e06d46f912002',
       i686: '8caf19357b4bb6303be7fe58cb42397978ef8179644efab1e33972c3c788c501',
     x86_64: 'fd60346c566038b898a0deb19255fd0efbc4d5b33d8b3915abb89937c7cf624a'
  })

  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R

  def self.patch
    # Update the PSL during build.
    downloader 'https://github.com/publicsuffix/list/raw/refs/heads/main/public_suffix_list.dat', 'SKIP', 'list/public_suffix_list.dat'
  end
end
