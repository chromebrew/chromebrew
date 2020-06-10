require 'package'

class Mksh < Package
  description 'The MirBSD Korn Shell'
  homepage 'https://www.mirbsd.org/mksh.htm'
  version '0.57'
  compatibility 'all'
  source_url 'http://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R57.tgz'
  source_sha256 '3d101154182d52ae54ef26e1360c95bc89c929d28859d378cc1c84f3439dbe75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mksh-0.57-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mksh-0.57-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mksh-0.57-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mksh-0.57-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ff71eee5a37906009ec8252e0b09400ea0acbf7519152ba34634baa59621f0a2',
     armv7l: 'ff71eee5a37906009ec8252e0b09400ea0acbf7519152ba34634baa59621f0a2',
       i686: 'b167da443ab2319501e45c0bb793b5fc75552a8749d4d28b31e46390689766d3',
     x86_64: '41f2613566cb9fb9a024eebff88ac61e2f47301c434f58bc217ff03443267e4b',
  })

  def self.build
    system 'sh Build.sh'
  end

  def self.check
#    system 'sh test.sh'
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
