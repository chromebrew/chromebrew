require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.2.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4010d189cb7963a92417e8a65a932395bf3cc628fc4e5b9ae6bd4fe8faa243e6',
     armv7l: '4010d189cb7963a92417e8a65a932395bf3cc628fc4e5b9ae6bd4fe8faa243e6',
       i686: '978abcb19aba7f71ea941752fc49d7893db91d9c9338c7e04b090cc46398a494',
     x86_64: 'ed8e4cd4548b77249b6406d310e4579247f1d7d7411b0fd5d1eb8ecc2496bba2'
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
