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
      system "curl https://doc-08-48-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/m9i9st4heasc0na51f3bmcjh30abgc22/1498096800000/15876260727594163214/*/0B3X9GlR6EmbnQ0FtZmJJUXEyRTA -o #{CREW_DEST_DIR}/usr/local/bin/gdrive"
    when 'armv7l'
      system "curl https://doc-08-48-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/eu3mqk3d95qv8taljje2duvn0dktolj9/1498096800000/15876260727594163214/*/0B3X9GlR6EmbnamliN0Rld01oRVk -o #{CREW_DEST_DIR}/usr/local/bin/gdrive"
    when 'mips64'
      system "curl https://doc-08-48-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/pj4u65jq8goaj179otteoe018a3q1m6m/1498096800000/15876260727594163214/*/0B3X9GlR6Embna2lzdEJ6blFzSzQ -o #{CREW_DEST_DIR}/usr/local/bin/gdrive"
    when 'ppc64'
      system "curl https://doc-0g-48-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/bnhrel73kb47t5gl31th03menie11qmm/1498096800000/15876260727594163214/*/0B3X9GlR6EmbnS09XMzhfRXBnUzA -o #{CREW_DEST_DIR}/usr/local/bin/gdrive"
    else
      abort 'Unable to install gdrive.  Architecture not supported.'.lightred
    end
    system "chmod +x #{CREW_DEST_DIR}/usr/local/bin/gdrive"
  end
end
