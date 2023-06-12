require 'package'

class Sphinx < Package
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version '4.2.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinx.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.2.0_armv7l/sphinx-4.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.2.0_armv7l/sphinx-4.2.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.2.0_i686/sphinx-4.2.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.2.0_x86_64/sphinx-4.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ce5176f31393c5a931194b48cf89d05e9632715ecd3595bfdb2a3fa18cb21705',
     armv7l: 'ce5176f31393c5a931194b48cf89d05e9632715ecd3595bfdb2a3fa18cb21705',
       i686: 'be2f188aedc8feed484b01481e22c7204e204a4507cf08463ff98c24c7ede010',
     x86_64: '402759f1a3779046dc33c905391d3d937d2371ba5f046c8aaa67b655504933aa'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_sphinxcontrib_devhelp'
  depends_on 'py3_sphinxcontrib_applehelp'
  depends_on 'py3_sphinxcontrib_jsmath'
  depends_on 'py3_sphinxcontrib_serializinghtml'
  depends_on 'py3_sphinxcontrib_qthelp'
  depends_on 'py3_sphinxcontrib_htmlhelp'
  depends_on 'py3_docutils'
  depends_on 'py3_imagesize'
  depends_on 'py3_requests'
  depends_on 'py3_babel'
  depends_on 'py3_alabaster'
  depends_on 'py3_pygments'
  depends_on 'py3_packaging'
  depends_on 'py3_snowballstemmer'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
