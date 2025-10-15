require 'buildsystems/autotools'

class Aide < Autotools
  description 'Advanced Intrusion Detection Environment'
  homepage 'https://aide.github.io'
  version '0.19.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/aide/aide.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9cbf008e39601340562e2cc77a42b13416ff72d5653ba39d7434274df18ca91',
     armv7l: 'f9cbf008e39601340562e2cc77a42b13416ff72d5653ba39d7434274df18ca91',
       i686: 'c007160a7df592aa4c0e1be863b79a88405dd525620f0ff3d65715d49dc28251',
     x86_64: '007f8b097f79a275b573e7d0801cafd2f2b8683d0a7acc355c6a5abc58a4b08a'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'check' => :build
  depends_on 'glibc' # R
  depends_on 'libgcrypt'
  depends_on 'mhash'
  depends_on 'nettle' # R
  depends_on 'pcre2'
  depends_on 'zlib'

  def self.patch
    # Aide requires some macros that do not exist in older kernel's headers. (for example, BPF_FS_MAGIC)
    #
    # Here is a copy of linux/magic.h from kernel 6.15, which includes all necessary macros for aide to compile.
    File.write 'linux-magic.h', <<~EOF
      /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
      #ifndef __LINUX_MAGIC_H__
      #define __LINUX_MAGIC_H__

      #define ADFS_SUPER_MAGIC  0xadf5
      #define AFFS_SUPER_MAGIC  0xadff
      #define AFS_SUPER_MAGIC                0x5346414F
      #define AUTOFS_SUPER_MAGIC  0x0187
      #define CEPH_SUPER_MAGIC  0x00c36400
      #define CODA_SUPER_MAGIC  0x73757245
      #define CRAMFS_MAGIC    0x28cd3d45  /* some random number */
      #define CRAMFS_MAGIC_WEND  0x453dcd28  /* magic number with the wrong endianess */
      #define DEBUGFS_MAGIC          0x64626720
      #define SECURITYFS_MAGIC  0x73636673
      #define SELINUX_MAGIC    0xf97cff8c
      #define SMACK_MAGIC    0x43415d53  /* "SMAC" */
      #define RAMFS_MAGIC    0x858458f6  /* some random number */
      #define TMPFS_MAGIC    0x01021994
      #define HUGETLBFS_MAGIC   0x958458f6  /* some random number */
      #define SQUASHFS_MAGIC    0x73717368
      #define ECRYPTFS_SUPER_MAGIC  0xf15f
      #define EFS_SUPER_MAGIC    0x414A53
      #define EROFS_SUPER_MAGIC_V1  0xE0F5E1E2
      #define EXT2_SUPER_MAGIC  0xEF53
      #define EXT3_SUPER_MAGIC  0xEF53
      #define XENFS_SUPER_MAGIC  0xabba1974
      #define EXT4_SUPER_MAGIC  0xEF53
      #define BTRFS_SUPER_MAGIC  0x9123683E
      #define NILFS_SUPER_MAGIC  0x3434
      #define F2FS_SUPER_MAGIC  0xF2F52010
      #define HPFS_SUPER_MAGIC  0xf995e849
      #define ISOFS_SUPER_MAGIC  0x9660
      #define JFFS2_SUPER_MAGIC  0x72b6
      #define XFS_SUPER_MAGIC    0x58465342  /* "XFSB" */
      #define PSTOREFS_MAGIC    0x6165676C
      #define EFIVARFS_MAGIC    0xde5e81e4
      #define HOSTFS_SUPER_MAGIC  0x00c0ffee
      #define OVERLAYFS_SUPER_MAGIC  0x794c7630
      #define FUSE_SUPER_MAGIC  0x65735546
      #define BCACHEFS_SUPER_MAGIC  0xca451a4e

      #define MINIX_SUPER_MAGIC  0x137F    /* minix v1 fs, 14 char names */
      #define MINIX_SUPER_MAGIC2  0x138F    /* minix v1 fs, 30 char names */
      #define MINIX2_SUPER_MAGIC  0x2468    /* minix v2 fs, 14 char names */
      #define MINIX2_SUPER_MAGIC2  0x2478    /* minix v2 fs, 30 char names */
      #define MINIX3_SUPER_MAGIC  0x4d5a    /* minix v3 fs, 60 char names */

      #define MSDOS_SUPER_MAGIC  0x4d44    /* MD */
      #define EXFAT_SUPER_MAGIC  0x2011BAB0
      #define NCP_SUPER_MAGIC    0x564c    /* Guess, what 0x564c is :-) */
      #define NFS_SUPER_MAGIC    0x6969
      #define OCFS2_SUPER_MAGIC  0x7461636f
      #define OPENPROM_SUPER_MAGIC  0x9fa1
      #define QNX4_SUPER_MAGIC  0x002f    /* qnx4 fs detection */
      #define QNX6_SUPER_MAGIC  0x68191122  /* qnx6 fs detection */
      #define AFS_FS_MAGIC    0x6B414653


      #define REISERFS_SUPER_MAGIC  0x52654973  /* used by gcc */
      #define REISERFS_SUPER_MAGIC_STRING  "ReIsErFs"
      #define REISER2FS_SUPER_MAGIC_STRING  "ReIsEr2Fs"
      #define REISER2FS_JR_SUPER_MAGIC_STRING  "ReIsEr3Fs"

      #define SMB_SUPER_MAGIC    0x517B
      #define CIFS_SUPER_MAGIC  0xFF534D42      /* the first four bytes of SMB PDUs */
      #define SMB2_SUPER_MAGIC  0xFE534D42

      #define CGROUP_SUPER_MAGIC  0x27e0eb
      #define CGROUP2_SUPER_MAGIC  0x63677270

      #define RDTGROUP_SUPER_MAGIC  0x7655821

      #define STACK_END_MAGIC    0x57AC6E9D

      #define TRACEFS_MAGIC          0x74726163

      #define V9FS_MAGIC    0x01021997

      #define BDEVFS_MAGIC            0x62646576
      #define DAXFS_MAGIC             0x64646178
      #define BINFMTFS_MAGIC          0x42494e4d
      #define DEVPTS_SUPER_MAGIC  0x1cd1
      #define BINDERFS_SUPER_MAGIC  0x6c6f6f70
      #define FUTEXFS_SUPER_MAGIC  0xBAD1DEA
      #define PIPEFS_MAGIC            0x50495045
      #define PROC_SUPER_MAGIC  0x9fa0
      #define SOCKFS_MAGIC    0x534F434B
      #define SYSFS_MAGIC    0x62656572
      #define USBDEVICE_SUPER_MAGIC  0x9fa2
      #define MTD_INODE_FS_MAGIC      0x11307854
      #define ANON_INODE_FS_MAGIC  0x09041934
      #define BTRFS_TEST_MAGIC  0x73727279
      #define NSFS_MAGIC    0x6e736673
      #define BPF_FS_MAGIC    0xcafe4a11
      #define AAFS_MAGIC    0x5a3c69f0
      #define ZONEFS_MAGIC    0x5a4f4653

      /* Since UDF 2.01 is ISO 13346 based... */
      #define UDF_SUPER_MAGIC    0x15013346
      #define DMA_BUF_MAGIC    0x444d4142  /* "DMAB" */
      #define DEVMEM_MAGIC    0x454d444d  /* "DMEM" */
      #define SECRETMEM_MAGIC    0x5345434d  /* "SECM" */
      #define PID_FS_MAGIC    0x50494446  /* "PIDF" */

      #endif /* __LINUX_MAGIC_H__ */
    EOF

    system 'sed', '-i', 's#<linux/magic.h>#"../linux-magic.h"#', 'src/file.c'
  end

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    File.write "#{CREW_DEST_PREFIX}/etc/aide.conf", <<~EOF
      # AIDE config file

      # Database initialization
      database_in=file:#{CREW_PREFIX}/etc/aide.db
      database_out=file:#{CREW_PREFIX}/etc/aide.db.new

      # What to check
      #{CREW_PREFIX}/bin R
      #{CREW_PREFIX}/sbin R
      #{CREW_PREFIX}/etc R
      #{HOME} R
      #{CREW_PREFIX}/var R

      # Exclude certain directories
      !/proc
      !/sys
      !/dev
      !/run
      !/tmp
      !/var/log
      !/var/cache
      !/var/tmp
    EOF
    FileUtils.touch "#{CREW_DEST_PREFIX}/etc/aide.db"
    FileUtils.touch "#{CREW_DEST_PREFIX}/etc/aide.db.new"
  end

  def self.postinstall
    ExitMessage.add <<~EOT

      Default configuration is at #{CREW_PREFIX}/etc/aide.conf.

      For information on the configuration format, run `man aide.conf`.

      Execute `aide -i` to get started.
    EOT
  end

  run_tests
end
