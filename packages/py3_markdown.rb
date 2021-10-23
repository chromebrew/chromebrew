require 'package'

class Py3_markdown < Package
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '3.3.4'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Python-Markdown/markdown.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_armv7l/py3_markdown-3.3.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_armv7l/py3_markdown-3.3.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_i686/py3_markdown-3.3.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_x86_64/py3_markdown-3.3.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c5673fba6bf85a943d5125967413be967ead29fa5cfd6e95487983fb2b2d97fa',
     armv7l: 'c5673fba6bf85a943d5125967413be967ead29fa5cfd6e95487983fb2b2d97fa',
       i686: '4a8f93f33a35a87c4e9ce6c9a70dba075baa4eb7db01167339d787f585712627',
     x86_64: 'cee25c9787684d247bd69809ec01485f6ab6a0dbcb9babd37c0a8efcbc503131'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
