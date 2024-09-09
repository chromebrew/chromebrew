require 'buildsystems/pip'

class Py3_olefile < Pip
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  version '0.47-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2572451de6da7ee9c47118cf32d5458fcdaac40eff4931ca1006c1d8ea51d71d',
     armv7l: '2572451de6da7ee9c47118cf32d5458fcdaac40eff4931ca1006c1d8ea51d71d',
       i686: '5584592924b8913cb74dc288b358a54fcf6a89e2ef09fba055358179c8dfdec2',
     x86_64: '887d07625f2add4615d6fa3fbefca0f10da9e6246fe6d4324d0a48b14b04328d'
  })

  depends_on 'python3' => :build

  no_source_build
end
