require 'buildsystems/pip'

class Py3_hatch_fancy_pypi_readme < Pip
  description 'MIT-licensed metadata plugin for Hatch'
  homepage 'https://github.com/hynek/hatch-fancy-pypi-readme'
  @_ver = '23.1.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_fancy_pypi_readme/23.1.0-py3.12_armv7l/py3_hatch_fancy_pypi_readme-23.1.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_fancy_pypi_readme/23.1.0-py3.12_armv7l/py3_hatch_fancy_pypi_readme-23.1.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_fancy_pypi_readme/23.1.0-py3.12_i686/py3_hatch_fancy_pypi_readme-23.1.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_fancy_pypi_readme/23.1.0-py3.12_x86_64/py3_hatch_fancy_pypi_readme-23.1.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e574d07804800a34fb575970416b0f66a9a431b9711c4b0544e934838b813580',
     armv7l: 'e574d07804800a34fb575970416b0f66a9a431b9711c4b0544e934838b813580',
       i686: '171c7340e1b3380387bb3cd5a44b2cb37815eb0c3e181379da982dd2c653bd58',
     x86_64: '2c1a9dcd4004b32f898b470d44ccbdb75b8e9e51c68deb6286166dadd680319f'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatch_vcs' => :build
end
