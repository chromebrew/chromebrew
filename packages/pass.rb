require 'package'

class Pass < Package
  description 'The standard unix password manager'
  homepage 'https://www.passwordstore.org/'
  version '1.7.1-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.zx2c4.com/password-store/snapshot/password-store-1.7.1.tar.xz'
  source_sha256 'f6d2199593398aaefeaa55e21daddfb7f1073e9e096af6d887126141e99d9869'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '0068206d91cb8b9b521456f9019f6a4aaf76d5a90ac55c568a6ee116d0998b65',
     armv7l: '0068206d91cb8b9b521456f9019f6a4aaf76d5a90ac55c568a6ee116d0998b65',
       i686: '77fb2f33e609b5df5ca27902e44156ce6e20ab85af9a0c7c754b45a9a8ea44e0',
     x86_64: '0b111fc35629c26203e3d709b9ec44c51f815d385d8b30fa1e852b5309db4af1'
  })

  depends_on 'gnupg'
  depends_on 'tree'

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
