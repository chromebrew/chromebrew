require 'package'

class Sleuthkit < Package
  description 'The Sleuth Kit® (TSK) is a library and collection of command line tools that allow you to investigate disk images.'
  homepage 'https://www.sleuthkit.org/sleuthkit/'
  version '4.4.1'
  source_url 'https://github.com/sleuthkit/sleuthkit/archive/sleuthkit-4.4.1.tar.gz'
  source_sha256 '91e2f038ff8407cfe38a26d18adc8dd98970e95db73394c188db98975deb23f7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8cccafa9d3434ac348fce223ee2d9d9db989d62bcaa2a0da0a396177b28cee3f',
     armv7l: '8cccafa9d3434ac348fce223ee2d9d9db989d62bcaa2a0da0a396177b28cee3f',
       i686: '6b8d6561c5b545604e75702adc2ce614a13a89780cd320d75b9ac6515f21fa27',
     x86_64: 'e03e322df272ad6a4d1f385b134d513298af3dedd94c79daa3e04fa684b079ab',
  })

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'gawk'
  depends_on 'libtool'
  depends_on 'zlibpkg'

  def self.build
    system './bootstrap'
    system 'sed -i "s,(sb.st_mode \& S_IFMT) == S_IFDIR,S_ISREG(sb.st_mode)," tsk/img/raw.c'
    system 'sed -i "s,#define TZNAME _tzname,extern char* tzname[2];\n#define TZNAME tzname," tsk/base/tsk_os.h'
    system 'sed -i "s,#define TZNAME\ttzname,," tsk/base/tsk_os.h'
    system 'sed -i "1iextern char* tzname[2];\n#define TZNAME tzname" tsk/fs/fs_name.c'
    system 'sed -i "1iint optarg[2];\nint optind;" tools/srchtools/srch_strings.c'
    system 'sed -i "0,/for (; optind < argc; ++optind)/s/for (; optind < argc; ++optind)/for (optind = 0; optind < argc; ++optind)/" tools/srchtools/srch_strings.c'
    system './configure \
            --disable-java \
            --without-afflib \
            --without-libewf'
    system "make 'CFLAGS=-std=c99'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
