require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "12.1.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94d59822b4f69d9910facdc765f1f40bf822f93dfd673af632544be04dba4bd5',
     armv7l: '94d59822b4f69d9910facdc765f1f40bf822f93dfd673af632544be04dba4bd5',
       i686: 'eef9ea112f40c04a52ab07a9a55a8c505e03b0ab49efc284869ff7a7d7083fa1',
     x86_64: '06a8fa801ccb30951cb5c6b4a1d78a28e909410746a36fdef79bf1051711a49e'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
