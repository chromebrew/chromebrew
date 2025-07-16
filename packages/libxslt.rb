require 'buildsystems/cmake'

class Libxslt < CMake
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxslt/-/wikis/home'
  version "1.1.43-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxslt.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1d114f2a2afacd0a7fa9232a52bc980b10ebfbcf647fd33a474d756c7f984b7',
     armv7l: 'e1d114f2a2afacd0a7fa9232a52bc980b10ebfbcf647fd33a474d756c7f984b7',
       i686: '68202b3dce43263f8fb736709f784d23b61778c52dff446b31b96377a5b72309',
     x86_64: 'c79821f48e3b9989906b8af0bc6fba147d9396ee656434ea53a067a241e474c4'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxml2_autotools' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
