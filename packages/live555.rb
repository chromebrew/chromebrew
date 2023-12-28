require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com/liveMedia/'
  version '2019.08.28'
  license 'LGPL'
  compatibility 'all'
  source_url 'http://www.live555.com/liveMedia/public/live.2019.08.28.tar.gz'
  source_sha256 'a3dcd157865186cf883c3a80b4bb09637e91fff96b234b2c780a7f7dcc7a35dc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/live555/2019.08.28_armv7l/live555-2019.08.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/live555/2019.08.28_armv7l/live555-2019.08.28-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/live555/2019.08.28_i686/live555-2019.08.28-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/live555/2019.08.28_x86_64/live555-2019.08.28-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ed43e0eead6cf26e0ab359f7f59611ae124afbaa640ce833ef7c564a8c52e772',
     armv7l: 'ed43e0eead6cf26e0ab359f7f59611ae124afbaa640ce833ef7c564a8c52e772',
       i686: 'e44f8ef9c1e9d2eee03eedee82bb1b263134ca55f8b718edcf993b04ec339c59',
     x86_64: '5a035da029b7efb476e917bb88053e709c29cda4ad06d2b7d1d6f47c40bb45a5'
  })

  def self.build
    system './genMakefiles linux'
    system 'make'
  end

  def self.install
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           'INSTALL2=install_shared_libraries',
           'install'
  end
end
