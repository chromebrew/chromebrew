require 'package'

class Cron < Package
  description 'Job scheduler - Background-only application which launches and runs other applications, or opens documents, at specified dates and times.'
  homepage 'https://directory.fsf.org/wiki/Cron'
  version '3.0pl1-128'
  source_url 'http://cdn-fastly.deb.debian.org/debian/pool/main/c/cron/cron_3.0pl1.orig.tar.gz'
  source_sha1 'f8d00de4c7c0eae97bedb4a3ec10ea21d43ece84'

  depends_on 'patch'
  depends_on 'vim'

  def self.patch
    system "wget http://cdn-fastly.deb.debian.org/debian/pool/main/c/cron/cron_3.0pl1-128.diff.gz"
    abort "Checksum mismatch. :/ Try again.".lightred unless Digest::SHA1.hexdigest( File.read("cron_3.0pl1-128.diff.gz") ) == "6b5c00d9dc79d05525f9f1bd76dbdbe4c540dc14"
    system "gunzip cron_3.0pl1-128.diff.gz"
    system "patch -p1 < cron_3.0pl1-128.diff"
  end

  def self.build
    self.patch
    system "make"
  end

  def self.install
    system "sudo mkdir -p /var/spool/cron/crontabs"
    system "sudo chgrp -R $(whoami) /var/spool/cron"
    system "sudo chmod -R g+w /var/spool/cron"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man5"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man8"
    system "mkdir -p #{CREW_DEST_DIR}/var/spool/cron/crontabs"
    system "cp cron #{CREW_DEST_DIR}/usr/local/bin"
    system "cp crontab #{CREW_DEST_DIR}/usr/local/bin"
    system "cp crontab.1 #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp crontab.5 #{CREW_DEST_DIR}/usr/local/man/man5"
    system "cp cron.8 #{CREW_DEST_DIR}/usr/local/man/man8"
    system "touch #{CREW_DEST_DIR}/var/spool/cron/crontabs/$(whoami)"
    puts ""
    puts "To start cron, execute: sudo cron".lightblue
    puts ""
    puts "In order to edit with crontab, you must assign the EDITOR environment variable:".lightblue
    puts "echo 'export EDITOR=/usr/local/bin/vim' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts ""
  end
end
