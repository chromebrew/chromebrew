require 'package'

class Py3_jinja2 < Package
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  @_ver = '3.0.2'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/jinja.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_armv7l/py3_jinja2-3.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_armv7l/py3_jinja2-3.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_i686/py3_jinja2-3.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_x86_64/py3_jinja2-3.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd523d068e3ef4f908ce2746d4315cc052d914e62457a99f538cb1bc1bc62ffc0',
     armv7l: 'd523d068e3ef4f908ce2746d4315cc052d914e62457a99f538cb1bc1bc62ffc0',
       i686: '71c0f00cc1a5977377be639dbb95d765fd87715b083e517fbea474512786ee70',
     x86_64: '311d96718373cf983ff17bfc810a8b275c52f8762fa90d64f2253e9cba874e61'
  })

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
