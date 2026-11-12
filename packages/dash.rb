require 'buildsystems/autotools'

class Dash < Autotools
  description 'The Debian Almquist Shell (dash) is a POSIX-compliant shell derived from ash that executes scripts faster than bash and has fewer library dependencies.'
  homepage 'https://salsa.debian.org/debian/dash/'
  version '0.5.13.6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/utils/dash/dash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d787b50ac4f9561cbbed9ed7c0418ba6fd3e8d36a11418fea6a0c6c14b59b67',
     armv7l: '5d787b50ac4f9561cbbed9ed7c0418ba6fd3e8d36a11418fea6a0c6c14b59b67',
       i686: '9ae195f20b5653af2fed852ed1f63a559651d66ec44d850e439ff7c6b8679680',
     x86_64: '95fb72974cd5ea70ee3be9f560e4b828d07371e54d4dab19e8e5a17ebebbee8a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libedit' => :executable

  autotools_configure_options '--with-libedit'

  run_tests
end
