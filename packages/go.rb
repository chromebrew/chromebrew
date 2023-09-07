require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.21.1'
  license 'BSD'
  compatibility 'all'
  source_url({
    aarch64: 'https://go.dev/dl/go1.21.1.linux-armv6l.tar.gz',
     armv7l: 'https://go.dev/dl/go1.21.1.linux-armv6l.tar.gz',
       i686: 'https://go.dev/dl/go1.21.1.linux-386.tar.gz',
     x86_64: 'https://go.dev/dl/go1.21.1.linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'f3716a43f59ae69999841d6007b42c9e286e8d8ce470656fb3e70d7be2d7ca85',
     armv7l: 'f3716a43f59ae69999841d6007b42c9e286e8d8ce470656fb3e70d7be2d7ca85',
       i686: 'b93850666cdadbd696a986cf7b03111fe99db8c34a9aaa113d7c96d0081e1901',
     x86_64: 'b3075ae1ce5dab85f89bc7905d1632de23ca196bd8336afd93fa97434cfa55ae'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/go"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
  end
end
