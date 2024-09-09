require 'buildsystems/pip'

class Py3_mock < Pip
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  version '5.1.0-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0887cdb5dfc42cd8727a4c7e5c9f9d857b05487b23079f95f5f82cc072f6955',
     armv7l: 'c0887cdb5dfc42cd8727a4c7e5c9f9d857b05487b23079f95f5f82cc072f6955',
       i686: '5221123d0d20eeb9d4fbf5183b643886c01d36ccb3539f65f3a2798f05a375f5',
     x86_64: '3ac7c87d9d6eca040e3373bd318ccf92c2554df90886a7ea9420f295b5dc23b6'
  })

  no_source_build
end
