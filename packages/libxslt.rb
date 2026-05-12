require 'buildsystems/cmake'

class Libxslt < CMake
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxslt/-/wikis/home'
  version "1.1.45-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxslt.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b154a1bc0b76b5cdf2e1916b545ad99d16215ad8caa88d22f36027d09eac020f',
     armv7l: 'b154a1bc0b76b5cdf2e1916b545ad99d16215ad8caa88d22f36027d09eac020f',
       i686: 'b0fddba65bec056655553af035d14061b236b0b957a9fa159becd1ab7bccc566',
     x86_64: '39dc95c3272c8075b49a14f67f1433c13693dadb1f0fa24efb130e5a473c399d'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glibc' # R
  depends_on 'libxml2' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
