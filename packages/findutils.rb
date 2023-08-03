require 'buildsystems/autotools'

class Findutils < Autotools
  description 'the basic directory searching utilities of the GNU operating system'
  homepage 'https://www.gnu.org/software/findutils/'
  version '4.8.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/findutils/findutils-4.8.0.tar.xz'
  source_sha256 '57127b7e97d91282c6ace556378d5455a9509898297e46e10443016ea1387164'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.8.0_armv7l/findutils-4.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.8.0_armv7l/findutils-4.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.8.0_i686/findutils-4.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.8.0_x86_64/findutils-4.8.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e20da96c2bc854e84a1f0f7f6f6876d5d5a36c8add7ebf3d8df94b64299ab25c',
     armv7l: 'e20da96c2bc854e84a1f0f7f6f6876d5d5a36c8add7ebf3d8df94b64299ab25c',
       i686: '3246911390cb99054dc438bf67f01bb91453363fb95e2c10a5cf9170d965d1f3',
     x86_64: '98a700b356ab5b021e51116cdbc80c86ee36168e8583bdd8e49a205938c18562'
  })

  depends_on 'python3'

  configure_options '--without-selinux'
  run_tests
end
