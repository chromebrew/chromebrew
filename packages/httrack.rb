require 'package'

class Httrack < Package
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.49.2-2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://mirror.httrack.com/httrack-3.49.2.tar.gz'
  source_sha256 '3477a0e5568e241c63c9899accbfcdb6aadef2812fcce0173688567b4c7d4025'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65be9f112bd18ec49d3d0425e9b49d9c0e4a1242419ea1b4bb28ac68ec29cc8b',
     armv7l: '65be9f112bd18ec49d3d0425e9b49d9c0e4a1242419ea1b4bb28ac68ec29cc8b',
       i686: '708949b7a3910a98d66c41db1c872ce1451e9afe43af38b06463a9218905cf17',
     x86_64: 'e2d6bd8daf3d21577b4f908a3e1c585791365d3befe7b0df450898f8fc8dba60'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
