require 'package'

class Codelite < Package
  description 'CodeLite is an open source, free, cross platform IDE specialized in C, C++, PHP and JavaScript'
  homepage 'https://codelite.org/'
  version '13.0'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/eranif/codelite/archive/13.0.tar.gz'
    source_sha256 'f2653fa42d6214999718236998cb223e6de00a498c0cfde795e901be693fb9ac'
    depends_on 'gtk2'
    depends_on 'hunspell'
    depends_on 'libssh'
    depends_on 'uchardet'
    depends_on 'wxwidgets'
    depends_on 'sommelier'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c66dfd41c532de8c20d5057790c112f42d549ce9d3874b53d36f591cd411a587',
     armv7l: 'c66dfd41c532de8c20d5057790c112f42d549ce9d3874b53d36f591cd411a587',
     x86_64: '3bcde4fa9a59939b654b1d6b7fbfe6edb7bad7759a3706f8498a85e7bc1d3dcb',
  })

  def self.patch
    system "for f in \$(grep -rn '\"/usr\"' | grep set | cut -d':' -f1 | sort | uniq); do sed -i 's,/usr,#{CREW_PREFIX},' \$f; done"
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
