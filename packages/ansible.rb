require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.0.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d11e945aad185691fe46f21544dcdebcbc2baaeee6db4f17200fcdc18a7ee7f',
     armv7l: '2d11e945aad185691fe46f21544dcdebcbc2baaeee6db4f17200fcdc18a7ee7f',
       i686: '67da4aa2cba0874f7a91ab8886f07a0369fc996425117aaa81d2cc33a807bb29',
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
