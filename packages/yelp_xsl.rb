require 'buildsystems/meson'

class Yelp_xsl < Meson
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://gitlab.gnome.org/GNOME/yelp-xsl'
  version '42.4'
  license 'GPL-2+, LGPL-2.1+, MIT and FDL-1.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/yelp-xsl.git'
  git_hashtag version
  source_sha256 '81b8d626a1481d542fb8c9cb890fa970ddc42b27f7779d52df31c4de0caac776'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac8cfea80a13e210f6e4f8f15d2769000c731030ea0ef6e3230240163e96af70',
     armv7l: 'ac8cfea80a13e210f6e4f8f15d2769000c731030ea0ef6e3230240163e96af70',
       i686: 'c71ab17b637d26403efb20724dd471109ffcdf5c2158c737bce290c315e5f570',
     x86_64: '279b9ca282c7d95f12c7a51c4bdf36cca94fe5459aae217f14c028b8af7374ea'
  })

  depends_on 'libxslt' => :build
  depends_on 'py3_itstool'

  gnome
end
