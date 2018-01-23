require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '1.5.1'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.5.1/stack-1.5.1-linux-arm.tar.gz'
    source_sha256 '91a6539494504f670223b8de5af2b87e67267d7c80b4372e6eb3a8577771dbb4'
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.5.1/stack-1.5.1-linux-i386.tar.gz'
    source_sha256 '2973f7baab2f557c113a92a560ad79b887bd57102e8f4a5caf67551a42ea4250'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.5.1/stack-1.5.1-linux-x86_64.tar.gz'
    source_sha256 'b7df551c2f67464bebc5859fc0ecb2dc59cdbeb525af09e05ea4f2752828e542'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4c7be5f76b9c48e2b87da03f69d1dc90567e1ccf2e7551a34b0eab29d0264c08',
     armv7l: '4c7be5f76b9c48e2b87da03f69d1dc90567e1ccf2e7551a34b0eab29d0264c08',
       i686: 'b478976d8e39abf913d2666f4f3da888d77655e7e97adce6f2411fb1b356780e',
     x86_64: 'a9b9e84bb5102b3b8cd2e8147e4fe9d1f15f37baf601600b19b13f987c4cd77b',
  })

  def self.install
    system "install -Dm755 stack #{CREW_DEST_PREFIX}/bin/stack"
  end
end
