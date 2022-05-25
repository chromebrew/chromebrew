require 'package'

class Fasd < Package
  description 'Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v.'
  homepage 'https://github.com/clvv/fasd'
  version '1.0.1-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/clvv/fasd/archive/1.0.1.tar.gz'
  source_sha256 '88efdfbbed8df408699a14fa6c567450bf86480f5ff3dde42d0b3e1dee731f65'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fasd/1.0.1-1_armv7l/fasd-1.0.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fasd/1.0.1-1_armv7l/fasd-1.0.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fasd/1.0.1-1_i686/fasd-1.0.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fasd/1.0.1-1_x86_64/fasd-1.0.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7a8f84519778bdd8c8d34b277d900016be6a5acdef97d7f18ddc22a59d43ffcc',
     armv7l: '7a8f84519778bdd8c8d34b277d900016be6a5acdef97d7f18ddc22a59d43ffcc',
       i686: '44dd17a46611a8adca2eac550c279155e9b971864b05082f3c936222a34e9c79',
     x86_64: '6af1c34541d0d4981da33a4fecd0d7a2da2e7f78370eeeefe98ba9ea609136ed'
  })

  def self.install
    system "sed -i 's,share/man,man,' Makefile"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @fasdenv = <<~FASDEOF
      # Fasd shell configuration
      eval \"\$(fasd --init auto)\"
    FASDEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/fasd", @fasdenv)
  end
end
