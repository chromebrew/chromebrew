require 'package'

class Gdrive < Package
  description 'Google Drive CLI Client'
  homepage 'https://www.google.com/drive/'
  version '2.1.0'

  source_url 'https://github.com/prasmussen/gdrive/archive/2.1.0.tar.gz'
  source_sha1 '2abfb27e9c0bfa1904bcfb6bd01b32ed6884db75'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    case ARCH
    when 'x86_64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA1.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '4fd8391b300cac45963e53da44dcfe68da08d843'
    when 'armv7l'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnamliN0Rld01oRVk&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA1.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '3d670905e13edf96d43c9f97293bdba62c740926'
    when 'mips64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6Embna2lzdEJ6blFzSzQ&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA1.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '334bbd74b87fd1d05550e366724fe8e3c9e61ca4'
    when 'ppc64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnS09XMzhfRXBnUzA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA1.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '70a1ac5be9ba819da5cf7a8dbd513805a26509ac'
    else
      abort 'Unable to install gdrive.  Architecture not supported.'.lightred
    end
    system "chmod +x #{CREW_DEST_DIR}/usr/local/bin/gdrive"
  end
end
