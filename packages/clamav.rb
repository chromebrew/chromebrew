require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.99.2-1'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.99.2.tar.gz'
  source_sha256 '167bd6a13e05ece326b968fdb539b05c2ffcfef6018a274a10aeda85c2c0027a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/clamav-0.99.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/clamav-0.99.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/clamav-0.99.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/clamav-0.99.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf8518c18e78b07483648ebd3e281ae3b49725e20b440dd56d896e92b8b29d7e',
     armv7l: 'bf8518c18e78b07483648ebd3e281ae3b49725e20b440dd56d896e92b8b29d7e',
       i686: 'c938db5fb8bd558dd96411073dc7dd552e1397fb40d6c4eef674bef36495e696',
     x86_64: 'e5e1f2fe2dabc34cccd029e3918fb44d4d5f2f1efcdf1dfe217d7d8199ec688a',
  })

  depends_on 'patch'
  depends_on 'autoconf'

  def self.build
    # Apply patch available at https://bugzilla.clamav.net/show_bug.cgi?id=11711.
    # This will be fixed in next release.
    system "curl -L 'https://bugzilla.clamav.net/attachment.cgi?id=7207' | patch -p0"
    system "autoconf"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
