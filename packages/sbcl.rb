require 'package'

class Sbcl < Package
  description 'Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.'
  homepage 'http://www.sbcl.org/index.html'
  version '2.0.3'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/sbcl/sbcl/2.0.3/sbcl-2.0.3-source.tar.bz2'
    source_sha256 'b5543f123214b2023ff5fc32dfd00b6cfeabd92c8edb33ad208842c4fd642f00'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/sbcl-2.0.3-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sbcl-2.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '0f6c5eba6d5ee12bee37436b3b61330741e92176a9f3142fa8e06269ba8665da',
    x86_64: '20d312cf33af72624225cb49fe5fb01035619e83889a826447c5f35a14cbe399',
  })

  depends_on 'clisp' => :build

  def self.build
    system "sh ./make.sh --prefix=#{CREW_PREFIX} --xc-host='clisp'"
  end

  def self.install
    system "INSTALL_ROOT=#{CREW_DEST_PREFIX} sh install.sh"
  end
end
