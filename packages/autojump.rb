require 'package'

class Autojump < Package
  description 'A cd command that learns - easily navigate directories from the command line'
  homepage 'https://github.com/wting/autojump'
  version '22.5.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/wting/autojump/archive/release-v22.5.3.tar.gz'
  source_sha256 '00daf3698e17ac3ac788d529877c03ee80c3790472a85d0ed063ac3a354c37b1'

  depends_on 'python3'

  no_compile_needed

  def self.build
    File.write 'autojump.sh', <<~EOF
      [[ -s #{CREW_PREFIX}/share/autojump/autojump.bash ]] && source #{CREW_PREFIX}/share/autojump/autojump.bash
    EOF
  end

  def self.install
    system "./install.py -p #{CREW_DEST_PREFIX}"
    FileUtils.install 'autojump.sh', "#{CREW_DEST_PREFIX}/etc/env.d/autojump.sh", mode: 0o755
  end
end
