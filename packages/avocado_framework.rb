require 'buildsystems/python'

class Avocado_framework < Python
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  version "113.0-#{CREW_PY_VER}"
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag version.split('-')[0]
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b526ec43448e6ee2fca8735381495b2df7481f1a2bbfbca4bb137c0dbc2bbd5',
     armv7l: '3b526ec43448e6ee2fca8735381495b2df7481f1a2bbfbca4bb137c0dbc2bbd5',
       i686: 'deeff8b83d48715bb0aaa53f238d00cb44e1b962c75feab67a94186fb16e30b2',
     x86_64: '9bb946e1c0d16701974d6d5d58ba917c8e19ba0f209966013573c40b1d8451e7'
  })

  depends_on 'python3' => :logical
  depends_on 'xdg_base'
  depends_on 'xzutils'
end
