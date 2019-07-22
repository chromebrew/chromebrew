require 'package'

class Mksh < Package
  description 'The MirBSD Korn Shell'
  homepage 'https://www.mirbsd.org/mksh.htm'
  version '0.57'
  source_url 'http://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R57.tgz'
  source_sha256 '3d101154182d52ae54ef26e1360c95bc89c929d28859d378cc1c84f3439dbe75'

  def self.build
    system 'sh Build.sh'
  end

  def self.check
    system 'sh test.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "install -c -s -m 555 mksh #{CREW_DEST_PREFIX}/bin/mksh"
#    Can't perform this step unless the filesystem is mounted as RW:
#    system 'grep -x /bin/mksh /etc/shells >/dev/null || echo /bin/mksh >>/etc/shells'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/mksh/examples"
    system "install -c -m 444 dot.mkshrc #{CREW_DEST_PREFIX}/share/doc/mksh/examples/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    system "install -c -m 444 lksh.1 mksh.1 #{CREW_DEST_PREFIX}/share/man/man1/"
  end

  def self.postinstall
    puts 'Please note: mksh cannot be set as the default shell in Chrome OS, as by default /etc' .lightgreen
    puts 'is mounted as read-only, so mksh cannot be added to the list of valid login shells in /etc/shells.' .lightgreen
    puts "For an example ~/.mkshrc file, copy #{CREW_PREFIX}/share/doc/mksh/examples/dot.mkshrc to #{HOME}/.mkshrc" .lightblue
  end
end
