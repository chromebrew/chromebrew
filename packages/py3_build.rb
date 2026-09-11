require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.6.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f2898cdf1d21fe6bbcede915af592265d6e576b48a52c3d496a0b91dccfbe66',
     armv7l: '4f2898cdf1d21fe6bbcede915af592265d6e576b48a52c3d496a0b91dccfbe66',
       i686: '30dc94481fa832115dd56108da7b1631747183821215371322004df41740c8ba',
     x86_64: '923aa9784393e1a9f4efa457c0279e96d3e57ae417ae8e1455645799488b669f'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
