require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.4.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85ec48532ed0719141e5dfc0810b19a791d37a726d2110e7139d040d21b1bd37',
     armv7l: '85ec48532ed0719141e5dfc0810b19a791d37a726d2110e7139d040d21b1bd37',
       i686: '45de1378029aeaa328f852d2fb917a4622c0b3c3b1b9c1529dfdc973c1fe4e63',
     x86_64: 'c20d79cfd515329bc83335e783905f5d960f681a32fcd49613734e5be3c708fb'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build

  def self.postremove
    Package.agree_to_remove("#{HOME}/.ansible")
  end
end
