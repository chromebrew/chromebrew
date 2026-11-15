require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.6.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acf57c0c53a22ab510e13a130fd8a9fbbd3f2e7a73f61d164433c57ba1a9a77c',
     armv7l: 'acf57c0c53a22ab510e13a130fd8a9fbbd3f2e7a73f61d164433c57ba1a9a77c',
       i686: '924c1b567ecefc8855bacb3691ae3e08f054045ac2a863f8c416ca89984e9187',
     x86_64: '6abdf56babe27bbe4fc58cc0a51c851c75f344ced7f62b61696cd232fed3a3b3'
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
