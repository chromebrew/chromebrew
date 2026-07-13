require 'package'

class Mksh < Package
  description 'The MirBSD Korn Shell'
  homepage 'https://www.mirbsd.org/mksh.htm'
  version '59c'
  license 'BSD'
  compatibility 'all'
  source_url "http://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R#{version}.tgz"
  source_sha256 '77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4dff577f5bac92f1bbc778690e32b2dc3f2ef870d0dd1f707e35101c6b4840c',
     armv7l: 'f4dff577f5bac92f1bbc778690e32b2dc3f2ef870d0dd1f707e35101c6b4840c',
       i686: '8503c38d4c0c3fe811980eefacb8cfac0f891f48c592c0b6c257b7a9755acfae',
     x86_64: '5c9309e81b77459c34c9bd5e0582e9cc4303e56d8a88f8e56ef29897870bd4ee'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'sh Build.sh'
  end

  def self.install
    FileUtils.install 'mksh', "#{CREW_DEST_PREFIX}/bin/mksh", mode: 0o755
    #    Can't perform this step unless the filesystem is mounted as RW:
    #    system 'grep -x /bin/mksh /etc/shells >/dev/null || echo /bin/mksh >>/etc/shells'
    FileUtils.install 'dot.mkshrc', "#{CREW_DEST_PREFIX}/share/doc/mksh/examples/dot.mkshrc", mode: 0o644
    FileUtils.install %w[lksh.1 mksh.1], "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM
      Please note: mksh cannot be set as the default shell in Chrome OS, as by default /etc
      is mounted read-only, so mksh cannot be added to the list of valid login shells in /etc/shells.
      For an example ~/.mkshrc file, copy #{CREW_PREFIX}/share/doc/mksh/examples/dot.mkshrc to #{HOME}/.mkshrc
    EOM
  end
end
