require 'package'

class Bashdb < Package
  description 'The Bash Debugger Project is a source-code debugger for bash that follows the gdb command syntax.'
  homepage 'http://bashdb.sourceforge.net/'
  version '4.4-0.92'
  source_url 'https://downloads.sourceforge.net/project/bashdb/bashdb/4.2-0.92/bashdb-4.4-0.92.tar.gz'
  source_sha256 'fb3d48a22b05d4e3c7a9b8205916d50fa33aac5908f0c9bcd15ff9d4dfa59c86'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.4-0.92-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.4-0.92-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.4-0.92-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.4-0.92-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea65d5d6ba8c8d670111228f0aeec56cd80a04640ae04f7c3ca621d7b9df8727',
     armv7l: 'ea65d5d6ba8c8d670111228f0aeec56cd80a04640ae04f7c3ca621d7b9df8727',
       i686: '916478bd373860c6a79f10429ad405f3e23bf5baafcf354ec0a1035721ef05f8',
     x86_64: 'df8d90fd5cb250db3fc34d128aeca5acc86742b79658267c51cce46c0a54ed7c',
  })

  def self.build
    system "./configure \
            --bindir=/usr/local/bin \
            --datadir=/usr/local/share \
            --infodir=/usr/local/info \
            --mandir=/usr/local/man"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
