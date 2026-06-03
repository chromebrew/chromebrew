require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.0.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ab9d2e64d78e3d556f44b4aa9749f161b71f441435e4ca312f1448be3d32bf9',
     armv7l: '7ab9d2e64d78e3d556f44b4aa9749f161b71f441435e4ca312f1448be3d32bf9',
       i686: '53137bf7202abc3711ab7dffa9834ad385e60a5e9147b1a8107459d3ace29fc7',
     x86_64: '077c08ca7fa35961a88a387a5bac420895046cbdaea7ab1e28c5bf746aa606bd'
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
