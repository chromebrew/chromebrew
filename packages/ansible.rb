require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.3.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26413b55113639872ca5a3ce2fd25d1b1e1fc858f9ea769166d8a3bcb38e2801',
     armv7l: '26413b55113639872ca5a3ce2fd25d1b1e1fc858f9ea769166d8a3bcb38e2801',
       i686: '89fb9d9cd5b629a9588e45306eb1306ebb949aef9076af6ee33881ec199addd2',
     x86_64: '2c994702e78ad2e2539c78d94dd8b55459b9f12373cb70f4ecc403ef50f16853'
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
