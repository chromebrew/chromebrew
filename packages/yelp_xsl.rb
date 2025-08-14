require 'buildsystems/meson'

class Yelp_xsl < Meson
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://gitlab.gnome.org/GNOME/yelp-xsl'
  version '42.4'
  license 'GPL-2+, LGPL-2.1+, MIT and FDL-1.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/yelp-xsl.git'
  git_hashtag "yelp-xsl-S{version}"
  source_sha256 '81b8d626a1481d542fb8c9cb890fa970ddc42b27f7779d52df31c4de0caac776'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2155ec95428055623c569db0dabe9fc91349aa011f83ce61acec26df2deb27e3',
     armv7l: '2155ec95428055623c569db0dabe9fc91349aa011f83ce61acec26df2deb27e3',
       i686: 'ff4a7cf7247e6a477bbac643b4e446d4ce45a32da1014673236e9764acc8d46c',
     x86_64: '03e70d4b552cb539c1799f1709bf22c20ddcb281b508c462aa146db023f9801c'
  })

  depends_on 'py3_itstool'

  gnome
end
