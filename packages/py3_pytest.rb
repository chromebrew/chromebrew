require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "8.3.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e90653cbfd8934bedb4655355de94f9df049d758049ca7001f76385ce79fb5af',
     armv7l: 'e90653cbfd8934bedb4655355de94f9df049d758049ca7001f76385ce79fb5af',
       i686: 'c4e7668a899e1bba44a931399386fdf76014981bbd954610a36fa026ff87e355',
     x86_64: '0b610d1b2fcb8fbb0b2cc1d048657f0e6bf51133c53926e1174ac7f5bdcf3507'
  })

  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'py3_packaging'
  depends_on 'py3_attrs'
  depends_on 'py3_pluggy'
  depends_on 'py3_iniconfig'
  depends_on 'python3' => :build

  no_source_build
end
