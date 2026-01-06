require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.2.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98a268e8386eb79796fb9afbf614351fd32a97b194b1d836b813b6248984782b',
     armv7l: '98a268e8386eb79796fb9afbf614351fd32a97b194b1d836b813b6248984782b',
       i686: 'd11c9e150c72e677fcecd88617d23ab0cb6df406943ecd57408e64ba5246594f',
     x86_64: '05b6e6f998837c38c6bfb4f3f2a7e22b36c1b033e5514b08b1fedbfb4b4b1314'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
