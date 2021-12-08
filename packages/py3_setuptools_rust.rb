require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '0.12.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_armv7l/py3_setuptools_rust-0.12.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_armv7l/py3_setuptools_rust-0.12.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_i686/py3_setuptools_rust-0.12.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_x86_64/py3_setuptools_rust-0.12.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd3213f711c5849174df09d5c198830887829bba9d61c0c9be7d607d207e3f522',
     armv7l: 'd3213f711c5849174df09d5c198830887829bba9d61c0c9be7d607d207e3f522',
       i686: 'cfeafb87059fc1fd28d8f3a7e15ad4721079631eec322af966ec7f519b5b2f8b',
     x86_64: '33fe45c89b8bd89171742de85b8bddd98ca0e6ed46dfab2cb429a40efa9ede45'
  })

  depends_on 'rust'
  depends_on 'py3_toml'
  depends_on 'py3_semantic_version'
  depends_on 'py3_setuptools'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
