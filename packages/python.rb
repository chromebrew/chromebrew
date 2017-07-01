require 'package'

class Python < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.3.2'
  binary_url ({
    aarch64: 'https://dl.dropboxusercontent.com/s/xsu18iggr51ewqh/python-3.3.2-chromeos-armv7l.tar.xz',
    armv7l:  'https://dl.dropboxusercontent.com/s/xsu18iggr51ewqh/python-3.3.2-chromeos-armv7l.tar.xz',
    i686:    'https://dl.dropboxusercontent.com/s/mxgfmq992hhiawk/python-3.3.2-chromeos-i686.tar.gz',
    x86_64:  'https://dl.dropboxusercontent.com/s/r1zvmza51hrr87q/python-3.3.2-chromeos-x86_64.tar.gz',
  })
  binary_sha256 ({
    aarch64: '0a89003a282daeea2a9232d98135582dbe3a620b600036cdc2ce71409f18fbe3',
    armv7l:  '0a89003a282daeea2a9232d98135582dbe3a620b600036cdc2ce71409f18fbe3',
    i686:    'dff30c6671aa3f378424f75eb704c6ef0fb806155a6e205246a06c9d347932df',
    x86_64:  '2a6f2786a82e1600abf795387ff80eb7407be9c2db94a10e58f59060b832388d',
  })
end
