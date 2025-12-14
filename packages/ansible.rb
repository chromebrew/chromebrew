require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.1.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d10a02d0af5e68e779d3e6dee4040b53eb77902077c4a5782d277395959c72c',
     armv7l: '6d10a02d0af5e68e779d3e6dee4040b53eb77902077c4a5782d277395959c72c',
       i686: 'cd40f56a409587d6cc7f464e4b6ecb72404c6a1a4bf3ccd4dcb7fa80b6439ea0',
     x86_64: '87ff0b764bcc692ae7f258bb31d112878c1090872c33c3be25ec67f685ac042b'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
