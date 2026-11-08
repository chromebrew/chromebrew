require 'package'

class Health_check_tool < Package
  description 'The health-check tool monitors processes in various ways to help identify areas where it is consuming too many resources.'
  homepage 'https://github.com/ColinIanKing/health-check'
  version '0.04.00'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ColinIanKing/health-check.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e3dd71a687f4f6ff8a2b0084e1a47cbcc7fa9ed7a1210ec3f2526da9fa952b6',
     armv7l: '3e3dd71a687f4f6ff8a2b0084e1a47cbcc7fa9ed7a1210ec3f2526da9fa952b6',
     x86_64: 'a0bab6da6a58126d5da19a86f3088a66a7aef20f672ae2b2971a3eb735f05b84'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'json_c' => :executable
  depends_on 'libbsd' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'health-check', "#{CREW_DEST_PREFIX}/bin/health-check", mode: 0o755
    FileUtils.install 'health-check.8', "#{CREW_DEST_PREFIX}/share/man/man8/health-check.8", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'health-check -h' to get started.\n"
  end
end
