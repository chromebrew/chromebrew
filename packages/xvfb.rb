require 'package'
Package.load_package("#{__dir__}/xorg_server.rb")

class Xvfb < Package
  description 'XVfb from Xorg Server.'
  homepage 'https://gitlab.freedesktop.org/xorg/xserver'
  version '21.1.23'
  license 'BSD-3, MIT, BSD-4, MIT-with-advertising, ISC and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '873e8fb0a937644fed1bb284a02462c303fd969746b6c23c15ab279abbafef2a',
     armv7l: '873e8fb0a937644fed1bb284a02462c303fd969746b6c23c15ab279abbafef2a',
     x86_64: 'f8936fcf50e6177a80bc285a82f7bf8b1bb52ac1c70089cc1e9487b8d1b58c14'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'libdrm' => :executable
  depends_on 'libfontenc' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libmd' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxfont2' => :executable
  depends_on 'libxkbfile' => :executable
  depends_on 'libxshmfence' => :executable
  depends_on 'pixman' => :executable
  depends_on 'xauth' => :logical
  depends_on 'xorg_server' => :build

  conflicts_ok # Xvfb is pulled from xorg_server.
  no_source_build

  def self.preflight
    abort 'Update xorg_server first.'.lightred if Gem::Version.new(version) > Gem::Version.new(Xorg_server.version.split('-').first)
  end

  def self.install
    # These two scripts are slightly modified from:
    # https://salsa.debian.org/xorg-team/xserver/xorg-server/-/blob/debian-unstable/debian/local/xvfb-run?ref_type=heads
    # Thus, these two scripts may be GPL.
    File.write 'xvfb-run', <<~XVFB_RUN_EOF
      #!#{CREW_PREFIX}/bin/bash

      # This script starts an instance of Xvfb, the "fake" X server, runs a command
      # with that server available, and kills the X server when done.  The return
      # value of the command becomes the return value of this script.
      #
      # If anyone is using this to build a Debian package, make sure the package
      # Build-Depends on xvfb and xauth.

      set -e

      PROGNAME=xvfb-run
      SERVERNUM=99
      AUTHFILE=
      : "${ERRORFILE:=/dev/stdout}"
      XVFBARGS="-screen 0 1280x1024x24"
      LISTENTCP="-nolisten tcp"
      XAUTHPROTO=.

      # Kill all other xvfb-run processes, just not this one.
      OTHER_XVFB_PROCESSES=$(pgrep -A -a -i xvfb | xargs)
      [[ $OTHER_XVFB_PROCESSES ]] && ( pkill -9 -p $OTHER_XVFB_PROCESSES || true )

      # Query the terminal to establish a default number of columns to use for
      # displaying messages to the user.  This is used only as a fallback in the event
      # the COLUMNS variable is not set.  ($COLUMNS can react to SIGWINCH while the
      # script is running, and this cannot, only being calculated once.)
      DEFCOLUMNS=$(stty size 2>/dev/null | awk '{print $2}') || true
      case "$DEFCOLUMNS" in
          *[!0-9]*|'') DEFCOLUMNS=80 ;;
      esac

      # Display a message, wrapping lines at the terminal width.
      message () {
          echo "$PROGNAME: $*" | fmt -t -w ${COLUMNS:-$DEFCOLUMNS}
      }

      # Display an error message.
      error () {
          message "error: $*" >&2
      }

      # Display a usage message.
      usage () {
          if [ -n "$*" ]; then
              message "usage error: $*"
          fi
          cat <<EOF
      Usage: $PROGNAME [OPTION ...] COMMAND
      Run COMMAND (usually an X client) in a virtual X server environment.
      Options:
      -a        --auto-servernum          try to get a free server number, starting at
                                          --server-num
      -e FILE   --error-file=FILE         file used to store xauth errors and Xvfb
                                          output (default: $ERRORFILE)
      -f FILE   --auth-file=FILE          file used to store auth cookie
                                          (default: ./.Xauthority)
      -h        --help                    display this usage message and exit
      -n NUM    --server-num=NUM          server number to use (default: $SERVERNUM)
      -l        --listen-tcp              enable TCP port listening in the X server
      -p PROTO  --xauth-protocol=PROTO    X authority protocol name to use
                                          (default: xauth command's default)
      -s ARGS   --server-args=ARGS        arguments (other than server number and
                                          "-nolisten tcp") to pass to the Xvfb server
                                          (default: "$XVFBARGS")
      EOF
      }

      # Find a free server number by looking at .X*-lock files in /tmp.
      find_free_servernum() {
          # Sadly, the "local" keyword is not POSIX.  Leave the next line commented in
          # the hope Debian Policy eventually changes to allow it in /bin/sh scripts
          # anyway.
          #local i

          i=$SERVERNUM
          while [ -f /tmp/.X$i-lock ]; do
              i=$(($i + 1))
          done
          echo $i
      }

      # Clean up files
      clean_up() {
          if [ -e "$AUTHFILE" ]; then
              XAUTHORITY=$AUTHFILE xauth remove ":$SERVERNUM" >&3 2>&3
          fi
          if [ -n "$XVFB_RUN_TMPDIR" ]; then
              if ! rm -r "$XVFB_RUN_TMPDIR"; then
                  error "problem while cleaning up temporary directory"
                  exit 5
              fi
          fi
          if [ -n "$XVFBPID" ]; then
              kill "$XVFBPID" >&3 2>&3
          fi
      }

      # Parse the command line.
      ARGS=$(getopt --options +ae:f:hn:lp:s:w: \
             --long auto-servernum,error-file:,auth-file:,help,server-num:,listen-tcp,xauth-protocol:,server-args:,wait: \
             --name "$PROGNAME" -- "$@")
      GETOPT_STATUS=$?

      if [ $GETOPT_STATUS -ne 0 ]; then
          error "internal error; getopt exited with status $GETOPT_STATUS"
          exit 6
      fi

      eval set -- "$ARGS"

      while :; do
          case "$1" in
              -a|--auto-servernum) SERVERNUM=$(find_free_servernum); AUTONUM="yes" ;;
              -e|--error-file) ERRORFILE="$2"; shift ;;
              -f|--auth-file) AUTHFILE="$2"; shift ;;
              -h|--help) SHOWHELP="yes" ;;
              -n|--server-num) SERVERNUM="$2"; shift ;;
              -l|--listen-tcp) LISTENTCP="" ;;
              -p|--xauth-protocol) XAUTHPROTO="$2"; shift ;;
              -s|--server-args) XVFBARGS="$2"; shift ;;
              -w|--wait) shift ;;
              --) shift; break ;;
              *) error "internal error; getopt permitted \"$1\" unexpectedly"
                 exit 6
                 ;;
          esac
          shift
      done

      if [ "$SHOWHELP" ]; then
          usage
          exit 0
      fi

      if [ -z "$*" ]; then
          usage "need a command to run" >&2
          exit 2
      fi

      if ! command -v xauth >/dev/null; then
          error "xauth command not found"
          exit 3
      fi

      # Open fd 3 for diagnostic output from Xvfb, etc.
      case "$ERRORFILE" in
          (/proc/self/fd/1 | /dev/stdout)
              # We might not actually be able to write to this if it's a file or
              # terminal owned by someone else, so duplicate the fd instead
              exec 3>&1
              ;;
          (/proc/self/fd/2 | /dev/stderr)
              # See above
              exec 3>&2
              ;;
          (*)
              exec 3>>"$ERRORFILE"
              ;;
      esac

      # tidy up after ourselves
      trap clean_up EXIT

      # If the user did not specify an X authorization file to use, set up a temporary
      # directory to house one.
      if [ -z "$AUTHFILE" ]; then
          XVFB_RUN_TMPDIR="$(mktemp -d -t $PROGNAME.XXXXXX)"
          AUTHFILE="$XVFB_RUN_TMPDIR/Xauthority"
          # Create empty file to avoid xauth warning
          touch "$AUTHFILE"
      fi

      # Start Xvfb.
      MCOOKIE=$(mcookie)
      tries=10
      while [ $tries -gt 0 ]; do
          tries=$(( $tries - 1 ))
          XAUTHORITY=$AUTHFILE xauth source - << EOF >&3 2>&3
      add :$SERVERNUM $XAUTHPROTO $MCOOKIE
      EOF
          # handle SIGUSR1 so Xvfb knows to send a signal when it's ready to accept
          # connections
          trap : USR1
          (trap '' USR1; exec Xvfb ":$SERVERNUM" $XVFBARGS $LISTENTCP -auth $AUTHFILE >&3 2>&3 3>&-) &
          XVFBPID=$!

          wait || :
          if kill -0 $XVFBPID 2>/dev/null; then
              break
          elif [ -n "$AUTONUM" ]; then
              # The display is in use so try another one (if '-a' was specified).
              SERVERNUM=$((SERVERNUM + 1))
              SERVERNUM=$(find_free_servernum)
              continue
          fi
          error "Xvfb failed to start" >&2
          XVFBPID=
          exit 1
      done

      # Start the command and save its exit status.
      set +e
      DISPLAY=:$SERVERNUM XAUTHORITY=$AUTHFILE "$@" 3>&-
      RETVAL=$?
      set -e

      # Return the executed command's exit status.
      exit $RETVAL

      # vim:set ai et sts=4 sw=4 tw=80:
    XVFB_RUN_EOF
    FileUtils.install 'xvfb-run', "#{CREW_DEST_PREFIX}/bin/xvfb-run", mode: 0o755

    File.write 'xvfb-run.1', <<~XVFB_RUN__MAN_EOF
      .\" Copyright 1998-2004 Branden Robinson <branden@debian.org>.
      .\"
      .\" This is free software; you may redistribute it and/or modify
      .\" it under the terms of the GNU General Public License as
      .\" published by the Free Software Foundation; either version 2,
      .\" or (at your option) any later version.
      .\"
      .\" This is distributed in the hope that it will be useful, but
      .\" WITHOUT ANY WARRANTY; without even the implied warranty of
      .\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      .\" GNU General Public License for more details.
      .\"
      .\" You should have received a copy of the GNU General Public License with
      .\" the Debian operating system, in /usr/share/common-licenses/GPL;  if
      .\" not, write to the Free Software Foundation, Inc., 59 Temple Place,
      .\" Suite 330, Boston, MA 02111-1307 USA
      .\"
      .\" We need the URL macro from groff's www macro package, but also want
      .\" things to work all right for people who don't have it.  So we define
      .\" our own URL macro and let the www macro package override it if it's
      .\" available.
      .de URL
      \\$2 \(laURL: \\$1 \(ra\\$3
      ..
      .if \n[.g] .mso www.tmac
      .TH xvfb\-run 1 "2004\-11\-12" "Debian Project"
      .SH NAME
      xvfb\-run \- run specified X client or command in a virtual X server environment
      .SH SYNOPSIS
      .B xvfb\-run
      [
      .I options
      ]
      .I command
      .SH DESCRIPTION
      .B xvfb\-run
      is a wrapper for the
      .BR Xvfb (1x)
      command which simplifies the task of running commands (typically an X
      client, or a script containing a list of clients to be run) within a virtual
      X server environment.
      .PP
      .B xvfb\-run
      sets up an X authority file (or uses an existing user\-specified one),
      writes a cookie to it (see
      .BR xauth (1x))
      and then starts the
      .B Xvfb
      X server as a background process.
      The process ID of
      .B Xvfb
      is stored for later use.
      The specified
      .I command
      is then run using the X display corresponding to the
      .B Xvfb
      server
      just started and the X authority file created earlier.
      .PP
      When the
      .I command
      exits, its status is saved, the
      .B Xvfb
      server is killed (using the process ID stored earlier), the X authority
      cookie removed, and the authority file deleted (if the user did not specify
      one to use).
      .B xvfb\-run
      then exits with the exit status of
      .IR command .
      .PP
      .B xvfb\-run
      requires the
      .B xauth
      command to function.
      .SH OPTIONS
      .TP
      .B \-a\fR,\fB \-\-auto\-servernum
      Try to get a free server number, starting at 99, or the argument to
      .BR \-\-server\-num .
      .TP
      .BI \-e\  file \fR,\fB\ \-\-error\-file= file
      Store output from
      .B xauth
      and
      .B Xvfb
      in
      .IR file .
      The default is
      .IR /dev/null .
      As a special case, specifying
      .B /proc/self/fd/2
      or
      .B /dev/stderr
      writes to standard error (without actually reopening the file descriptor), while
      .B /proc/self/fd/1
      or
      .B /dev/stdout
      writes to standard output.
      .TP
      .BI \-f\  file \fR,\fB\ \-\-auth\-file= file
      Store X authentication data in
      .IR file .
      By default, a temporary directory called
      .IR xvfb\-run. PID
      (where PID is the process ID of
      .B xvfb\-run
      itself) is created in the directory specified by the environment variable
      .B TMPDIR
      (or
      .I /tmp
      if that variable is null or unset), and the
      .BR tempfile (1)
      command is used to create a file in that temporary directory called
      .IR Xauthority .
      .TP
      .B \-h\fR,\fB \-\-help
      Display a usage message and exit.
      .TP
      .BI \-n\  servernumber \fR,\fB\ \-\-server\-num= servernumber
      Use
      .I servernumber
      as the server number (but see the
      .B \-a\fR,\fB \-\-auto\-servernum
      option above).
      The default is 99.
      .TP
      .B \-l\fR,\fB \-\-listen\-tcp
      Enable TCP port listening in the X server.
      For security reasons (to avoid denial\-of\-service attacks or exploits),
      TCP port listening is disabled by default.
      .TP
      .BI \-p\  protocolname \fR,\fB\ \-\-xauth\-protocol= protocolname
      Use
      .I protocolname
      as the X authority protocol to use.
      The default is \(oq.\(cq, which
      .B xauth
      interprets as its own default protocol, which is MIT\-MAGIC\-COOKIE\-1.
      .TP
      .BI \-s\  arguments \fR,\fB\ \-\-server\-args= arguments
      Pass
      .I arguments
      to the
      .B Xvfb
      server.
      Be careful to quote any whitespace characters that may occur within
      .I arguments
      to prevent them from regarded as separators for
      .BR xvfb\-run 's
      own arguments.
      Also, note that specification of \(oq\-nolisten tcp\(cq in
      .I arguments
      may override the function of
      .BR xvfb\-run 's
      own
      .B \-l\fR,\fB \-\-listen\-tcp
      option, and that specification of the server number (e.g., \(oq:1\(cq) may
      be ignored because of the way the X server parses its argument list.
      Use the
      .B xvfb\-run
      option
      .BI \-n\  servernumber \fR,\fB\ \-\-server\-num= servernumber
      to achieve the latter function.
      The default is \(oq\-screen 0 1280x1024x24\(cq.
      .TP
      .BI \-w\  delay \fR,\fB\ \-\-wait= delay
      Ignored for compatibility with earlier versions.
      .SH ENVIRONMENT
      .TP
      .B COLUMNS
      indicates the width of the terminal device in character cells.
      This value is used for formatting diagnostic messages.
      If not set, the terminal is queried using
      .BR stty (1)
      to determine its width.
      If that fails, a value of \(oq80\(cq is assumed.
      .TP
      .B TMPDIR
      specifies the directory in which to place
      .BR xvfb\-run 's
      temporary directory for storage of the X authority file; only used if the
      .B \-f
      or
      .B \-\-auth\-file
      options are not specified.
      .SH "OUTPUT FILES"
      .PP
      Unless the
      .B \-f
      or
      .B \-\-auth\-file
      options are specified, a temporary
      directory and file within it are created (and deleted) to store the X
      authority cookies used by the
      .B Xvfb
      server and client(s) run under it.
      See
      .BR tempfile (1).
      If \-f or \-\-auth\-file are used, then the specified X authority file is
      only written to, not created or deleted (though
      .B xauth
      creates an authority file itself if told to use use that does not already
      exist).
      .PP
      An error file with a user\-specified name is also created if the
      .B \-e
      or
      .B \-\-error\-file
      options are specified; see above.
      .SH "EXIT STATUS"
      .B xvfb\-run
      uses its exit status as well as output to standard error to communicate
      diagnostics.
      The exit status of \(oq1\(cq is not used, and should be interpreted as failure
      of the specified command.
      .TP
      0
      .B xvfb\-run
      only uses this exit status if the
      .B \-h\fR,\fB \-\-help
      option is given.
      In all other situations, this may be interpreted as success of the specified
      command.
      .TP
      2
      No command to run was specified.
      .TP
      3
      The
      .B xauth
      command is not available.
      .TP
      4
      The temporary directory that was going to be used already exists; since
      .B xvfb\-run
      produces a uniquely named directory, this may indicate an attempt by another
      process on the system to exploit a temporary file race condition.
      .TP
      5
      A problem was encountered while cleaning up the temporary directory.
      .TP
      6
      A problem was encountered while using
      .BR getopt (1)
      to parse the command\-line arguments.
      .SH EXAMPLES
      .TP
      .B xvfb\-run \-\-auto\-servernum \-\-server\-num=1 xlogo
      runs the
      .BR xlogo (1x)
      demonstration client inside the
      .B Xvfb
      X server on the first available server number greater than or equal to 1.
      .TP
      .B xvfb\-run \-\-server\-args="\-screen 0 1024x768x24" ico \-faces
      runs the
      .BR ico (1x)
      demonstration client (and passes it the
      .B \-faces
      argument) inside the
      .B Xvfb
      X server, configured with a root window of 1024 by 768 pixels and a color
      depth of 24 bits.
      .PP
      Note that the demo X clients used in the above examples will not exit on
      their own, so they will have to be killed before
      .B xvfb\-run
      will exit.
      .SH BUGS
      See
      .URL "https://bugs.debian.org/xvfb" "the Debian Bug Tracking System" .
      If you wish to report a bug in
      .BR xvfb\-run ,
      please use the#{' '}
      .BR reportbug (1)
      command.
      .SH AUTHOR
      .B xvfb\-run
      was written by Branden Robinson and Jeff Licquia with sponsorship from
      Progeny Linux Systems.
      .SH "SEE ALSO"
      .BR Xvfb (1x),
      .BR xauth (1x)
      .\" vim:set et tw=80:
    XVFB_RUN__MAN_EOF
    FileUtils.install 'xvfb-run.1', "#{CREW_DEST_MAN_PREFIX}/man1/xvfb-run.1", mode: 0o644

    puts 'Installing xorg_server to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'xorg_server.filelist')
    abort 'File list for xorg_server does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless filename.include?('Xvfb')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
