require 'buildsystems/autotools'

class Xmlto < Autotools
  description 'A tool for converting XML files to various formats.'
  homepage 'https://pagure.io/xmlto'
  version '0.0.29'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://pagure.io/xmlto.git'
  git_hashtag version
  binary_compression 'tar.zst'

  depends_on 'docbook_xml' => :build
  depends_on 'glibc' # R
  depends_on 'libxslt' # L

  binary_sha256({
    aarch64: '84648d642bf518c5255965623656899ae24fdf07dc78f57f4b69e8f594a30ada',
     armv7l: '84648d642bf518c5255965623656899ae24fdf07dc78f57f4b69e8f594a30ada',
       i686: 'be441b9ee3112a00f969592fddfe7b1ad03da1518eb651b8ed4a17102a04beb3',
     x86_64: '22abd629186ff27fd93f7fad53ea09270d4fab7881aee1aec0681eec1d7e2211'
  })
end
