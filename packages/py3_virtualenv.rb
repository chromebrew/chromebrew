require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d67fae7390d237041160bf6c3cedc72df75b79108f0896282c1258c499749ad',
     armv7l: '1d67fae7390d237041160bf6c3cedc72df75b79108f0896282c1258c499749ad',
       i686: '69b1f245e87052f17ba96a71291b5ccf76ec67442231df78505bcb01f1af33ac',
     x86_64: '8d69f24416268b31338000ba141bb360c3030696981374f5638022995ab58288'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
