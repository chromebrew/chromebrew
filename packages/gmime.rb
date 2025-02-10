require 'buildsystems/autotools'

class Gmime < Autotools
  description 'GMime is a powerful MIME (Multipurpose Internet Mail Extension) utility library. It is meant for creating, editing, and parsing MIME messages and structures.'
  homepage 'https://developer.gnome.org/gmime/'
  version '3.2.15'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jstedfast/gmime.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1dc01a8bfdbb7058ddcfe98030ce742a499f4992104af6f709584cc729889a0e',
     armv7l: '1dc01a8bfdbb7058ddcfe98030ce742a499f4992104af6f709584cc729889a0e',
     x86_64: '8af3eff73005d645fb83ec90888d4b9e36903d64324bf7010289de71d9a6ca9b'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gpgme' # R
  depends_on 'libassuan' # R
  depends_on 'libgpg_error' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  gnome

  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/jstedfast/gmime/pull/171.diff', 'a9532d24030babcbdf2cfe09c9dc9274c7607f5cf1d3544996a0353b3eb36354', '171.diff'
    system 'patch -Np1 -i 171.diff'
  end
end
