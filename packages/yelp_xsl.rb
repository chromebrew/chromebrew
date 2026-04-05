require 'buildsystems/meson'

class Yelp_xsl < Meson
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://gitlab.gnome.org/GNOME/yelp-xsl'
  version '49.0'
  license 'GPL-2+, LGPL-2.1+, MIT and FDL-1.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/yelp-xsl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a62685144135c65f00cc579cc142460adf04d6e853fa9441cd64f61484f5c14b',
     armv7l: 'a62685144135c65f00cc579cc142460adf04d6e853fa9441cd64f61484f5c14b',
       i686: '58e37b70404d22b55546d7157d2163118479625bd378b6feb29d55bf08b2f62f',
     x86_64: '1422904acd5c0ea8dfcddf471daee1953d0a298f1c49bfebd2193c6f5e59b518'
  })

  depends_on 'libxslt' => :build
  depends_on 'py3_itstool'

  gnome
end
