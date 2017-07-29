require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '1.4.0'

  case ARCH
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.4.0/stack-1.4.0-linux-i386.tar.gz'
    source_sha256 'aabd307f7dcb585a7821d7b44a73527f0928a76c48711e6968262ee87c86bc14'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.4.0/stack-1.4.0-linux-x86_64.tar.gz'
    source_sha256 '618a309d763432a2cca654bc29249a77c7de096c693a28b84dd3656470269f5a'
  else
    # dummy file
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.4.0/stack-1.4.0-linux-x86_64.tar.gz'
    source_sha256 '618a309d763432a2cca654bc29249a77c7de096c693a28b84dd3656470269f5a'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    case ARCH
    when 'i686', 'x86_64'
      system "cp stack #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    else
      # create stack from scratch as described at https://docs.haskellstack.org/en/stable/README/
      system "curl -sSL https://get.haskellstack.org/ | sh -s - -d #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    end
  end
end
