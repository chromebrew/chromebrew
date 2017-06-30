require 'package'

class Gdrive < Package
  description 'Google Drive CLI Client'
  homepage 'https://www.google.com/drive/'
  version '2.1.0'

  source_url 'https://github.com/prasmussen/gdrive/archive/2.1.0.tar.gz'
  source_sha256 'a1ea624e913e258596ea6340c8818a90c21962b0a75cf005e49a0f72f2077b2e'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    case ARCH
    when 'aarch64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnamliN0Rld01oRVk&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '83cfcad8e1f39d3b7ae9407d34a624d1951d616cadb89841613b588cac468fa8'
    when 'armv7l'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnamliN0Rld01oRVk&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '83cfcad8e1f39d3b7ae9407d34a624d1951d616cadb89841613b588cac468fa8'
    when 'x86_64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == 'f31b441c5cdb835ee69849a62856e35c17954fd5b600f6de8a6f5d7bd7bf0420'
    when 'mips64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6Embna2lzdEJ6blFzSzQ&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == 'df9fc86b782bb313a65633b90294e1167993bf7527e9d1aecdbb8937571bdb20'
    when 'ppc64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnS09XMzhfRXBnUzA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '3560ef4971cb9fc02785fa652bb9d3525253b853a744540cc717e578c329bfe4'
    end
    system "chmod +x #{CREW_DEST_DIR}/usr/local/bin/gdrive"
  end
end
