require 'package'

class Tre < Package
  description 'The approximate regex matching library and agrep command line tool.'
  homepage 'https://github.com/laurikari/tre'
  version '6fb720'
  source_url 'https://github.com/laurikari/tre/archive/6fb7206b935b35814c5078c20046dbe065435363.tar.gz'
  source_sha256 'd2810576685b10c6bf9270793550032bdada04afd963fa4670a08fdc57859bdd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb720-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb720-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb720-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb720-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd1a70784e6c8ac70318b7657db67a5d121fa88f908ae8a1ec675969c1dfd78b9',
     armv7l: 'd1a70784e6c8ac70318b7657db67a5d121fa88f908ae8a1ec675969c1dfd78b9',
       i686: '349a32bed7bc73379a4804dadea91047148e7c8a9b2186564a6ec17a4a77968c',
     x86_64: 'a6ad1a69e7bdb0643cceefa03ebdabefe956e76299660e9a75d7afc679bc2e3f',
  })

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'gettext'
  depends_on 'libtool'

  def self.build
    system './utils/autogen.sh'
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
