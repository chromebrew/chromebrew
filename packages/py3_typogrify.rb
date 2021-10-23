require 'package'

class Py3_typogrify < Package
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '2.0.7'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mintchaos/typogrify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_armv7l/py3_typogrify-2.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_armv7l/py3_typogrify-2.0.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_i686/py3_typogrify-2.0.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_x86_64/py3_typogrify-2.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'aa82d372f53c2a17335825228ab1da7bd67965211e7f1188a146fc2d9d9204dc',
     armv7l: 'aa82d372f53c2a17335825228ab1da7bd67965211e7f1188a146fc2d9d9204dc',
       i686: '3237802ba6c8e8e43c0012bf9523ae56f9839019389180a8fd922703bb9bac6f',
     x86_64: '95021726b9cc51241edd87658cfe8bb467936dc587c67d1d8a6a00e5b4e766df'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
