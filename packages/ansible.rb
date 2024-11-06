require 'buildsystems/python'

class Ansible < Python
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.17.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/ansible/ansible.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9062621a2fa226e56059a777f2a7ea35f632c7a0866c5b1bcfa5b933e09350f0',
     armv7l: '9062621a2fa226e56059a777f2a7ea35f632c7a0866c5b1bcfa5b933e09350f0',
       i686: 'b38555e1996ca01a2180a88dccf22c85a46ab94b6248fe3fa2078667d293eb4c',
     x86_64: '6741f337d27cd106fdc721f3bccb536c5f6f42cd3cd3ff650f32a7729970c353'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build
end
