require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.1.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97ea10fe54a6f319de16585f07670557a60ed83bb08cf5b450678623846a77ed',
     armv7l: '97ea10fe54a6f319de16585f07670557a60ed83bb08cf5b450678623846a77ed',
       i686: 'e2ee9fa8d4ff98aceb0710b530c34a5b5ae912f470b00ceeef23c37cd785494c',
     x86_64: '049f72e540547e7074a62204feb089daae287484ee34b9cf12c86c5727460347'
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
