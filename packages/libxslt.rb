require 'buildsystems/autotools'

class Libxslt < Autotools
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxslt/-/wikis/home'
  version '1.1.42'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxslt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68f4c8281e74d9aa4c2bf239b7594b0e9387b9939b0dedfa7f4eedc997967989',
     armv7l: '68f4c8281e74d9aa4c2bf239b7594b0e9387b9939b0dedfa7f4eedc997967989',
       i686: '9db4d4820596eeba61bc9a716fb8c6890e730d56da506855ce8d6cddff8b7d48',
     x86_64: '88a5cf436936c419189bcb2cc19b4bb1c1077f8f70d7e8048e687866c150ab17'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libxml2' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2_autotools' # R

  configure_options '--disable-static'
end
