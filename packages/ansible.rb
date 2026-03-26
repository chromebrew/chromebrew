require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.5.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8020eada7ffc2dca4056dd0bbd9bb68871f7f6e28aa8ecc15df8ba4244049fbe',
     armv7l: '8020eada7ffc2dca4056dd0bbd9bb68871f7f6e28aa8ecc15df8ba4244049fbe',
       i686: '9e1c3766f5b7504d640ae238504589d2794abf96c40ecb6f16dbe484e5bd0cd9',
     x86_64: 'bfb8bd87666470ed7f795ba2107883e3baafffca6825452eac8edbb41e58333c'
  })

  depends_on 'py3_cryptography'
  depends_on 'py3_jinja2'
  depends_on 'py3_packaging'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :logical
  depends_on 'xdg_base'

  no_source_build

  def self.postremove
    Package.agree_to_remove("#{HOME}/.ansible")
  end
end
