require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  @_ver = '1.18.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatchling/1.18.0-py3.12_armv7l/py3_hatchling-1.18.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatchling/1.18.0-py3.12_armv7l/py3_hatchling-1.18.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatchling/1.18.0-py3.12_i686/py3_hatchling-1.18.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatchling/1.18.0-py3.12_x86_64/py3_hatchling-1.18.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '633982364ac92b10f63373b7c76e1242f03cbaaa893a42cd41c4949b2950784e',
     armv7l: '633982364ac92b10f63373b7c76e1242f03cbaaa893a42cd41c4949b2950784e',
       i686: '709755a9a9b6bbd9bb3fabd4d003f3638e31369e233822659be5e27a8df2343c',
     x86_64: '51fe66009ae9a30ce099ace7fc218b5f39eaae8536a1804479f14f5c902b329d'
  })

  depends_on 'python3' => :build
  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
end
