require 'package'

class Pass < Package
  description 'The standard unix password manager'
  homepage 'https://www.passwordstore.org/'
  version '1.7.4'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://git.zx2c4.com/password-store/snapshot/password-store-#{version}.tar.xz"
  source_sha256 '4c2d0a8b99df8915a87099607a8d912fd05d30651b6f014745c14e4ca8dbbfb7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13eaef75e3e5940f93d00bebb4fa2104c90ec542773c1dbbc1b4329f957beb97',
     armv7l: '13eaef75e3e5940f93d00bebb4fa2104c90ec542773c1dbbc1b4329f957beb97',
       i686: '2554133a8a18b795e65e91644eec367d854307cef888ee4da0ba3da6d8fa48b1',
     x86_64: 'a8964951549e340e9ac8ae0e5b21729379c052da83bee07e78198aa9d60b0a2a'
  })

  depends_on 'gnupg'
  depends_on 'tree'

  print_source_bashrc

  def self.build
    File.write '10-pass', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/bash-completion/completions/pass
    EOF
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install '10-pass', "#{CREW_DEST_PREFIX}/etc/env.d/10-pass", mode: 0o644
  end
end
