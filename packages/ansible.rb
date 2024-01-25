require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.11.6'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/ansible/ansible.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'e99dda3d567d2f51088c406f87cf4a046253414af0f772449acdaf5c580990c6',
     armv7l: 'e99dda3d567d2f51088c406f87cf4a046253414af0f772449acdaf5c580990c6',
       i686: 'e4e6c38d5cbac73ad2504b7815e7e119976943b0f04dd74d69f6a13b46efd0fb',
     x86_64: 'a3fc4acfca1229ca1c2bbb1c8107e4ee207afea58f092796daecb17e42a3b9fb'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
