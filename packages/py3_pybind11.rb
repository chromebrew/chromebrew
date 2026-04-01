require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.0.3-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '127e15a932990b358176e0ade0764afc26c9695e5a345d0f08869cf629e997fb',
     armv7l: '127e15a932990b358176e0ade0764afc26c9695e5a345d0f08869cf629e997fb',
       i686: '40a4ee22f47dc693deddd1dcbcfaf02a50d14e2f40c02e7e4cbb96203c5544d7',
     x86_64: 'bfb49229ea3f6c0974bdf9db940f8e7a225a34fef46471f42e4f9ccd0c89e7c3'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
