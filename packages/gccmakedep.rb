require 'package'

class Gccmakedep < Package
  description 'A utility to list the resource database of an X application.'
  homepage 'https://x.org'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/gccmakedep-1.0.3.tar.gz'
  source_sha256 'f9e2e7a590e27f84b6708ab7a81e546399b949bf652fb9b95193e0e543e6a548'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
