require 'buildsystems/python'

class Py3_agate < Python
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  @_ver = '1.7.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7166b2366d7a8e36c80b35d868ccbeaa3b4ed3c9fcd9f12cb81ee2e8bc3b47f3',
     armv7l: '7166b2366d7a8e36c80b35d868ccbeaa3b4ed3c9fcd9f12cb81ee2e8bc3b47f3',
       i686: '6aa482e07efae894990e6118f9804f42da282a517e9cbc636a448f50116d0bf2',
     x86_64: '3a39c31a9950946ddc2359980f470e9754ff91c707535ffe485ffc05e7a2d1c1'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'python3' => :build
end
